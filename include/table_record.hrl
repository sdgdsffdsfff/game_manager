-record( activity_task, {id, uid, tableId, state, num, completeNum} ).

-record( acu, {id, uid, gangMainLv, gangMinorLv, footMainLv, footMinorLv, hideMainLv, hideMinorLv, magicMainLv, magicMinorLv} ).

-record( answer_record, {id, uid, answerList, answerNum, totalNum, trueNum, errorNum, flag, time} ).

-record( att_main_info, {id, uid, attUid, time} ).

-record( attr, {uid, name, sex, txt, gangId, styleId, camp, weaponStyle, lv, exp, gold, rmb, vit, ge, learn, rank, teamRank, practice, strength, realm, realmExp, teamNum, teamLv, teamStrength, guildId, downlineTime, revise, addHp, drug, canPvpNum, manager, createTime, onlineTime, friendPassNum, gagTime, vitBuyNum, sweepPoint, canBuyPoint, closure, choice, platformId, refreshTime} ).

-record( bag, {id, uid, size} ).

-record( boss, {id, type, lv} ).

-record( box_record, {id, uid, x, y, quality, type, typeId, num, time} ).

-record( building, {id, uid, type, lv} ).

-record( cdkey_used, {id, uid, cdkey} ).

-record( current_instance, {id, uid, instanceId, mode, currentFight, dropList} ).

-record( daily_task, {id, uid, tableId, quality, currentSeat, num, task_1, quality_1, isAccept_1, task_2, isAccept_2, quality_2, task_3, isAccept_3, quality_3, task_4, isAccept_4, quality_4, lostTime, freeNum, completeNum, toZeroTime} ).

-record( day_online_time, {date, uid, platformId, time, logincount} ).

-record( debug_trace_info, {id, debugTraceInfo, time} ).

-record( delete_temporary_item, {id, uid, tableId, num} ).

-record( drop_table, {id, drop} ).

-record( drug_buff, {id, uid, itemId, drugId, time} ).

-record( drug_cost, {id, uid, costId, num, drugNum, time} ).

-record( email, {id, uid, fromUid, receiveTime, title, info, appendix, isRead, isGet} ).

-record( energe_record, {id, uid, time, energe} ).

-record( energe_task, {id, uid, energeTask, prize1, prize2, prize3, prize4} ).

-record( equ, {id, uid, tableId, quality, maxHp, normalAtt, magicAtt, normalDef, magicDef, rageAdd, agile, hit, block, crit, addNum, teamAddNum, gem1, gem2, gem3, gem4, gem5, isWear, state, time, star} ).

-record( equ_state, {id, uid, succinctTime, addTime, succinctNum, todayNum} ).

-record( fight_attr, {id, uid, maxHp, normalAtt, magicAtt, normalDef, magicDef, maxRage, rageAdd, agile, crit, block, blockDmg, hit, critDmg, style_1, style_2, style_3, style_4, style_5, style_6, by_1, by_2, by_3} ).

-record( first_open_equ_treasure, {id, uid, flag, time} ).

-record( friend, {id, uid_1, uid_2, intimacy, friendState, teamState, joinTime} ).

-record( fun_open, {id, uid, funList} ).

-record( ge_rank, {rank, uid, value} ).

-record( gem_lv_up, {id, uid, itemId} ).

-record( give_mate, {uid} ).

-record( gm_log, {id, uid, name, time, type, info} ).

-record( gold_cost, {id, uid, costId, num, goldNum, time, itemId, num1, lvl} ).

-record( herbal_garden, {id, uid, farm, farmStartTime, farmHelpList, farmStealList, treeNum, treeHelpList, treeHelpNum, maxTreeHelpNum, farmerTime, farmerExp, farmerQuality, farmerLv, clearTime, toCompleteNum, infoList} ).

-record( hotel, {id, uid, lostRefresh, recruitNum, openNum, freeNum, role_1, food_1, state_1, time_1, role_2, food_2, state_2, time_2, role_3, food_3, state_3, time_3, role_4, food_4, state_4, time_4, role_5, food_5, state_5, time_5, role_6, food_6, state_6, time_6} ).

-record( instance, {id, uid, instanceId, mode, modeScore_1, modeScore_2, modeScore_3} ).

-record( item, {id, uid, tableId, num, state, time} ).

-record( item_use_record, {id, uid, tableId, useType, num, time} ).

-record( league, {id, leagueName, leagueLv, leagueExp, leagueNum, leagueRank, leagueStrength, leagueWealth, leagueCharge, leagueDebt, leaguePayTime, leagueState, leaguefeeFlag, leagueCreateTime, leagueCreateUid, leagueBossUid, leagueNotice, leaguebrief, leagueInfoState, fightState, targetLeagueId, fightStartTime, fightEndTime, payWealth, loseProTime, avoidProTime, avoidState, applyChallengeTime} ).

-record( league_building, {leagueId, normalBuildingList, guardBuildingList} ).

-record( league_contribute_cost, {id, uid, itemId, num, contribute, time} ).

-record( league_daily_task, {id, uid, tableId, quality, currentSeat, num, task_1, quality_1, isAccept_1, task_2, isAccept_2, quality_2, task_3, isAccept_3, quality_3, task_4, isAccept_4, quality_4, lostTime, freeNum, completeNum} ).

-record( league_escort_record, {id, leagueId, uid, escortId, eventId, num, rmb, completeNum, operationList, eventList, gridEventList, rewardList, allEventList, time} ).

-record( league_fight, {id, uid, fightState, targetLeagueId} ).

-record( league_fight_history, {id, leagueNameWin, leagueNameLose, time} ).

-record( league_guard, {uid, feedNum, addHpNum} ).

-record( league_member, {id, uid, leagueId, leaguePay, currentPay, memberLv, currentContribute, memberExp, memberContribute, memberPosition, memberState, getPayState, applyLeagueTime, joinLeagueTime} ).

-record( league_mine, {leagueId, mine_1, loseTime_1, mine_2, loseTime_2, mine_3, loseTime_3, mine_4, loseTime_4, mine_5, loseTime_5} ).

-record( league_record, {'Id', leagueId, uid, uid1, uid2, type, type1, time} ).

-record( league_wealth_record, {id, leagueId, mineMoney, leagueWealth, buildingFee, money, payWealth, finalLeagueWealth, time} ).

-record( league_wish_record, {'Id', leagueId, uid, type, pay, time} ).

-record( learn, {id, uid, lostTime, refreshNum, getNum, learnTableVOId, lostLearn, time} ).

-record( learn_cost, {id, uid, costId, num, learnNum, time} ).

-record( leave_word, {id, uid, fromUid, fromName, sex, vipLv, 'Info'} ).

-record( lineup, {id, uid, tableId, seat_1, seat_2, seat_3, seat_4, seat_5, seat_6, seat_7, seat_8, seat_9} ).

-record( lineup_lose_hp, {uid, teamUid, loseHp} ).

-record( lineup_use, {id, uid, useId} ).

-record( location, {id, uid, x, y} ).

-record( login, {id, uid, dateList, signTime, continuationDays} ).

-record( login_ip_record, {id, uid, guid, platformId, ip, module, version, manufacturer, time} ).

-record( lottery, {lotteryTableId, num} ).

-record( lv_up_prize, {uid, lvList} ).

-record( make_drug, {id, uid, makeDrugId} ).

-record( mate_attr, {id, uid, mateId, lv, exp, loseHp, byRelationList, num, isFight, skillId, skillLv, style1Lv, style2Lv, style3Lv, style4lv, style5Lv, style6Lv, maxHp, normalAttr, magicAttr, normalDef, magicDef} ).

-record( mate_equ, {id, uid, mateId, tableId, quality, addNum, isWear, state, exp, totalExp, time} ).

-record( mate_equ_box_record, {id, uid, x, y, quality, type, typeId, num, time} ).

-record( mate_equ_use, {id, uid, tableId, useType, time} ).

-record( mate_fight_attr, {id, mateId, maxHp, normalAtt, magicAtt, normalDef, magicDef, maxRage, rageAdd, agile, crit, block, blockDmg, hit, critDmg} ).

-record( mate_layer, {id, uid, mateId, layer, lv} ).

-record( mate_record, {uid, mateId, handle, time, typeId} ).

-record( mate_recruit, {id, uid, time1, time2, time3, num, dayNum} ).

-record( mate_title, {id, uid, type, lv, exp, totalExp, state, time} ).

-record( mate_title_bag, {id, uid, maxNum} ).

-record( mate_title_groove, {id, uid, mateId, groove1, groove2, groove3, groove4, groove5, groove6, groove7, groove8} ).

-record( mate_title_use, {id, uid, type, lv, useType, time} ).

-record( mate_type, {id, uid, typeList} ).

-record( mate_will, {id, uid, quality, num, time} ).

-record( mate_will_use, {id, uid, quality, num, time} ).

-record( mine, {id, uid, hostUid, guardUid, first, levyTime, gold, lostLevyTime, attTime} ).

-record( mine_reward, {id, uid, gold, state} ).

-record( month_card, {uid, currentCard, startTime, getTimeList, cardMoney} ).

-record( new_year_prize, {uid, num} ).

-record( online_prize, {id, uid, prize, accPrize, timePrize} ).

-record( pharmacy, {id, uid, drug} ).

-record( practice_rank, {rank, uid, value} ).

-record( queue, {id, uid, building_1, lock_1, isOpen_1, buildingStart_1, building_2, lock_2, isOpen_2, buildingStart_3, building_3, lock_3, isOpen_3, buildingStart_2, skill_1, skillIsOpen_1, skillStart_1} ).

-record( realm, {id, uid, mainLv, minorLv} ).

-record( recharge_prize, {id, uid, num, time, day_1, day_2, day_3, day_4, day_5} ).

-record( recharger_record, {id, uid, originalMoney, orderMoney, platformId, payId, time} ).

-record( reg, {id, uid, regX, regY} ).

-record( rmb_cost, {id, uid, costId, num, rmbNum, time, itemId, num1, lvl} ).

-record( role_list, {id, uid, roleId, lost} ).

-record( seller, {id, uid, itemList} ).

-record( server_info, {name, ip, port, maxOnline, maxTime, startTime, serverState, serverDec, maxPlayer, serverName, serverDefault} ).

-record( server_state, {date, platformId, rmb, max, maxTime, min, minTime, allOnline, hour_0, hour_1, hour_2, hour_3, hour_4, hour_5, hour_6, hour_7, hour_8, hour_9, hour_10, hour_11, hour_12, hour_13, hour_14, hour_15, hour_16, hour_17, hour_18, hour_19, hour_20, hour_21, hour_22, hour_23, payUser, allRmb, newPayUser, payUserInfo, newUser, one, three, seven, onlineTime, m10, m30, h1, h2, h3, h5, thanH5, lv} ).

-record( set_skill, {id, uid, skill_1, skill_2, skill_3, skill_4, skill_5, skill_6, by_1, by_2, by_3, magic_1, magic_2, magic_3} ).

-record( skill, {id, uid, tableId, skillLv, styleLv_1, styleLv_2, styleLv_3, styleLv_4, styleLv_5, styleLv_6, studyNum, addRate} ).

-record( skill_by, {id, uid, tableId, lv} ).

-record( skill_magic, {id, uid, tableId, lv} ).

-record( stest, {test} ).

-record( str_info, {id, class, a, b, c, d, e, f, g, uid} ).

-record( strength_rank, {rank, uid, value} ).

-record( sys_notic, {id, beginTime, difTime, num, txt} ).

-record( target, {id, uid, tableId, state, num, drop} ).

-record( task, {id, uid, tableId, state, num_1, num_2, num_3} ).

-record( team_rank, {id, uid, rank, num, lostTime, lostAttTime, nextRewardTime, isReward, rewardRank, buyNum, exercise} ).

-record( team_share, {id, uid, toUid, gold, exp, learn, year, month, day, getNum} ).

-record( ticket, {id, uid, ticket, type, time, isget} ).

-record( ticket_win, {id, type, ticket, time} ).

-record( trace_info, {id, traceInfo, time} ).

-record( uid_pass, {uid} ).

-record( user_pack, {id, uid, packId, type, data, time, runTime, guid} ).

-record( vip, {id, uid, vipExp, isGiftGet, vipLv, getPrizeList, vipRechargePrize} ).

-record( xw_global, {teamRankRewardTime, regNum} ).

