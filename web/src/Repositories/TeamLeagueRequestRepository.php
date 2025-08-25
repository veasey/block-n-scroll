<?php
namespace App\Repositories;

use App\Enums\TeamLeagueRequestStatus;
use App\Models\TeamLeagueRequest;
use App\Models\League;

class TeamLeagueRequestRepository
{
    public function getNewRequests(League $league, array $params): mixed     
    {
        return TeamLeagueRequest::where('league_id', $league->id)
            ->where('status', TeamLeagueRequestStatus::PENDING->value)
            ->skip($params['offset'])
            ->take($params['perPage'])
            ->orderBy('created_at', 'desc')
            ->get();
    }

    public function getNewRequestsTotalCount(League $league): int
    {
        return TeamLeagueRequest::where('league_id', $league->id)
            ->where('status', TeamLeagueRequestStatus::PENDING->value)
            ->count();
    }

    public function findById(int $id): ?TeamLeagueRequest
    {
        return TeamLeagueRequest::find($id);
    }
}