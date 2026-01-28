Return-Path: <linux-can+bounces-6335-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UA3zIibseWkF1AEAu9opvQ
	(envelope-from <linux-can+bounces-6335-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 11:59:50 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 019A19FD9A
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 11:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BDDC3011C6A
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 10:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEDE332EA7;
	Wed, 28 Jan 2026 10:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="omu9UAO2";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Da2E5x11"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0715B2BE03D
	for <linux-can@vger.kernel.org>; Wed, 28 Jan 2026 10:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769597715; cv=pass; b=u7u96kYsvJRhu8OVZZOIrAngE7NmK2Ed5Z9PY6F7BaG9tzjQpiT8KZMNGM3ofm59Ffd2CZusLpSU8AMDKT8qeQaa6UguiNmLEoZRfjamarSvPtfEbQOAyDxsWN99x+A0l3OckQtJ0QUXnCo/pbxNdHK2S0iF/qcDojWnSWmMHPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769597715; c=relaxed/simple;
	bh=KbqH86mbCrX+ZBy+M6vlmZE5MFGM6PvVYbjoCgn2kcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TucvIm2J0EYvQlqfK9/bkrKaL1OtQpgc3ve7HX9YfA5cF+enUhzy+DQzwlQ1fKrsopP6b+5ph2oFf3cwdOxz98C5nKUg/9kDkwcF8Pba8q3olFahY2QAYrRK1KsuYSbgH1ug0neZcvj9ITLPx4xQFvg/WC3DpXCCR24t2DMo6dM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=omu9UAO2; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Da2E5x11; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1769597523; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Ajuy1rYUOiN4F9yuR+YPetymDCW0GIZ/WtWyDaF/nCanw2Ojghlm1zBnkwsbSShQfb
    UWECR6B5bnj4D+vo5l96jll5vNGFbpYOh55rlpoz18KSFvyy6JadLgWTQDCK/E9eJFjm
    wxvSULVpicJABZ8YUJfShi13JK78JMgFfr0uX+WOuuXuxz8Q6IbToI5fTQ5mwKWjizqY
    fhespIjYwMNaHexE0wvezgC/QIjeD+GJ4yjDF558fHCTWY182VBFA8NtGE0RYe9TcuAP
    OBZy2xH0lQRJIDByY9iXWHYKp7lIJTOqA8UtAqwAA4J2j98fLH3xiao5NaR/otyN0k/L
    zmMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1769597523;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=2TF+H9aU5o3SWBnxNUH5iTZAIhbj5EqcUqiEuuRcXPI=;
    b=LNYWNc0zqGMqjYqmfngZd/fRNglAoF2oN7hOGRABdW0taxT7aR8D4yzPR53SMZscLS
    TkwjoewLOI+cxPglyXQgJiKM95e6aoeKJFxNczvUiw4cU9TP5JETr2gyG5yhCYIWL7mN
    BkkUFNF/44XepHs7kJiTq3E5s7MFF9oHuHiC98Mx2eYWeYH607Oy8pljjvGTUaQqJeR1
    ToCVrlJgCyAy/H8fAydq3OKZqwSmatgGoNZ2bYUWTfYFfI6QzysBoqusZH50wsu0RdJ4
    XFn9T94Cdw40SA5txIapzOjziWOG24DYYoytVM6InB/L/Mf2mNsSf/iSny//t9WEqenk
    9uJQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1769597523;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=2TF+H9aU5o3SWBnxNUH5iTZAIhbj5EqcUqiEuuRcXPI=;
    b=omu9UAO2ougs95X9SHKxZT0GvJwOP4v3P5QxU4+gyh+vUcVrpZQ/C+dB4O7mS3Gat6
    l36FnDA0UkyXFt4StQhY+TuCGbY5wMaexoGnM6hiZ3+58gwq0/kqquUrqXpFWpNULxVl
    6QQEub3v70FEfPfi/ZouIlxtmY9RxekvdeAD+KztWdQUpojd24A6oKh5wo9TxKqcepS/
    q/IXVy9E/FUvICrt24xeq/KSVmDu2FYOOBxG1z+r3g2vQ1tCvLjoCSDS53yhWwzkC1fZ
    i0ibTqHR7rgwfSYPsngDbtDUQVegbTYyjJPcHhdxrz+X294SU72QndPfGQ6eNREngULh
    r+Ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1769597523;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=2TF+H9aU5o3SWBnxNUH5iTZAIhbj5EqcUqiEuuRcXPI=;
    b=Da2E5x11a+Mx/678Q/7bLVQkq5UUaQd9F5kbY7/RgB1ziJL8SCrvsqWux+iidE/8dT
    g4OLV67IGl3FHEOc46Dg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8YjX10Q=="
Received: from [IPV6:2a00:6020:4a38:6810::76e]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b20SAq3laN
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 28 Jan 2026 11:52:03 +0100 (CET)
Message-ID: <913b1ce2-1926-44dc-bd7d-046c30bc0fc4@hartkopp.net>
Date: Wed, 28 Jan 2026 11:52:02 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: bcm: disable bh when updating filter and timer
 values
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org,
 syzbot+75e5e4ae00c3b4bb544e@syzkaller.appspotmail.com
References: <20260126161711.2374-1-socketcan@hartkopp.net>
 <20260128-festive-reindeer-of-vitality-5f0f7f-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260128-festive-reindeer-of-vitality-5f0f7f-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6335-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can,75e5e4ae00c3b4bb544e];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hartkopp.net:mid,hartkopp.net:dkim,pengutronix.de:url]
X-Rspamd-Queue-Id: 019A19FD9A
X-Rspamd-Action: no action



On 28.01.26 11:25, Marc Kleine-Budde wrote:
> On 26.01.2026 17:17:11, Oliver Hartkopp wrote:
>> KCSAN detected a simultaneous access to timer values that can be
>> overwritten in bcm_rx_setup when updating timer and filter content.
>> This caused no functional issues in the past as the new values might
>> show up at any time without losing its intended functionality.
> 
>> Btw. the KCSAN report can be easily resolved by protecting the
>> 'lockless' data updates with local_bh_[dis|en]able().
> 
> What's the exact problem we have here?
> 
> Simultaneous access or modification (which one?) of op->frames,
> op->last_frames, op->nframes, op->flags from the timer and
> bcm_rx_setup()?

In opposite to the bcm op locking, where two sides are writing data to 
the variables, we can overwrite existing content in bcm_rx_setup().

The softirq side is only reading the filters and timer settings when a 
CAN frame is received. There is no concurrent write.

> How does disabling the bh on the local CPU only solve the problem? What
> happens if the timer is currently running?

There are two potential timers (timeout of cyclic messages and throttle 
timer) that can be rearmed in the softirq. There is no issue IMO and it 
was no problem in the past.

KCSAN only remarked that writing the updated values and reading these 
values happened at the same time.

And I think this can exactly be solved with local_bh_disable().
Other code in the kernel using local_bh_disable() use the same pattern 
and asking the KI about the use case of local_bh_disable() fits to this fix.

Best regards,
Oliver

> Also see patch c2aba69d0c36 ("can: bcm: add locking for bcm_op runtime
> updates") and the related discussion.
> 
> regards,
> Marc
> 
> --
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung Nürnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |


