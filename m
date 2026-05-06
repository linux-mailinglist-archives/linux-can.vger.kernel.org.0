Return-Path: <linux-can+bounces-7530-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIz1Mq8t+2npXAMAu9opvQ
	(envelope-from <linux-can+bounces-7530-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 06 May 2026 14:01:51 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E18B4D9EFE
	for <lists+linux-can@lfdr.de>; Wed, 06 May 2026 14:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B29DD300B633
	for <lists+linux-can@lfdr.de>; Wed,  6 May 2026 12:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC5B335091;
	Wed,  6 May 2026 12:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="omFzNYJ6";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="It9Hplh9"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66D83B8BBF
	for <linux-can@vger.kernel.org>; Wed,  6 May 2026 12:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.220
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778068842; cv=pass; b=HA9EeF5JnCnx553onKd8mAoXwgYsblO5MIyla2uzvJUvulbrjYXfvevWcsJQs7UytwVeEGfFg86RBRq7J7RdMagxqInDUwuWjwhVwdrwMrFbJgEeQwy17lfrlviYgJ5tuMYPauX0w6AxznPGynx2CQmXF0v2K5lEvJu7COyzbsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778068842; c=relaxed/simple;
	bh=+6sqbU86n7LwqIfq+QjysXnoYvfn+I7mrHomMaLIo6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YNVNn6fD3awQZ5NzQ9alliuwTJPbWevjuqx5Bg03g3cErgVTkaT/BBkOOOJx0IId66EkWzLMwRT12eSnZ2rFbGbyG8DyIBS8lv+rk1k87NNX8yWfv7jEpw0qqg9YdILc5IKsQ2Lv3ce6QjBBDGTFLePufWq0080HKb8+wwekjdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=omFzNYJ6; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=It9Hplh9; arc=pass smtp.client-ip=81.169.146.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1778068470; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=DHStDaMOxEbEDnOpudpDEWmeeQYWGBjfd/bR5J/8ALPrFrjicpYvwSwLdCtVVhLAq+
    /cVJvXuZoOqcO9im/DMf84LyP6ArzOLogbDQgdgC+a26gIKQvZNb+zo4uDaMVJNEgBCJ
    E+oFrMpHpXhwXDcGvC3JYPw704jaFsKTFkv3bFIM4+zC2Roxf5JWPhb4j3M9YGQikYEB
    2sHPWlvV2dH0aBG2d9vkKVhkbHQZ+UHRzdeEkW+01vJMQcZg9P9E75sgDMSlTLR499ls
    N61uluGJZ7Elryq5/kg0OSQAv90O8JSA4pM8aTBLIhNAIWJtOvhIyqXW2vLh5UhDx/4b
    rt8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1778068470;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ve5HqiTXqKKMoX47gbWYDUGjz+JiaCX7/parC47c64c=;
    b=BSyKUX/EyDLUBiU2YNpIE7XMaYQzWsvb21nYM7yWsOjVlUR/ZdrzsFPU0k7T/bzJ36
    mo2mi+dyHzJqOlEJ3nW+8ZpUfKaJljxtRcsk0gh3t6Vef1dI8QU/8EUYL9RMeCtWLwWl
    NQbROuu/SF/l1GKqJqFmJSendXc+f+Re3tIHXtkGRKcnvDjlKFFvE0BxCszAOYp6VJJG
    +pyiltwjG1/nq8isShMmfI1OQBG/SpPevMVbYCuUlH72R2/ILNROgZR0B4pnCdKE9cwM
    BWWcpu11dB22XbLlbCxnsQ5ovfETHhr3rHO16Ju0XR7cJ22/Zth7R7HcujYukpGXtDnW
    IniQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1778068470;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ve5HqiTXqKKMoX47gbWYDUGjz+JiaCX7/parC47c64c=;
    b=omFzNYJ6lfVNhBUuSA3UkgOYjuQA37NImHnAeoyb7n0Ege1orPBCJCUHgzIYisqssa
    eNTaQRsth7TPUhq52vSlz3nRQjLwxXp9NtTS5qQEsvRdHyRRX0mRouaCOH9EbYqLodu4
    X+ws+zKF08sFXH6ALop9dbkodpwOHGn6AqLIiMb1gDJZZsOH4oYEXhw7qsBsGqmNUXIK
    06VBScrYWNLRdytX/3C1kQ+5AwuzmxRjqwd4Ki4Nx0a6d+osDO/7zE5OvLqiliUlHaed
    i2BCcn056hVOazkoINLcfelaVIundrvQbdvez+2KfL/eeENUgdWPSNFQ+AHyTLzLAfcE
    EGiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1778068470;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ve5HqiTXqKKMoX47gbWYDUGjz+JiaCX7/parC47c64c=;
    b=It9Hplh9KtcCObWLu4USzPKdA0g4ly+Q+BVlJaOXI81qs6W0m4X15aDzjzFaUAx7sT
    KXNg50z1PjyIXJ0C7rAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s1YTqptmo87qzm6sElmZEI+VN6rw=="
Received: from [IPV6:2a00:6020:4a38:6800:3499:34c0:1f42:76da]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d246BsSVq9
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 6 May 2026 13:54:28 +0200 (CEST)
Message-ID: <9110e56c-42e7-4299-963e-2e42f73b0eff@hartkopp.net>
Date: Wed, 6 May 2026 13:54:23 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: raw: add locking for raw flags bitfield
To: Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, Eulgyu Kim <eulgyukim@snu.ac.kr>,
 Marc Kleine-Budde <mkl@pengutronix.de>
References: <20260504111928.41856-1-socketcan@hartkopp.net>
 <CAMZ6RqJdF4xit5xvpGy6P9Nkenh6PT0meVpcL3UYZKx01yfQAg@mail.gmail.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAMZ6RqJdF4xit5xvpGy6P9Nkenh6PT0meVpcL3UYZKx01yfQAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6E18B4D9EFE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7530-lists,linux-can=lfdr.de];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[snu.ac.kr:query timed out,hartkopp.net:query timed out];
	RCVD_COUNT_THREE(0.00)[4];
	RSPAMD_URIBL_FAIL(0.00)[snu.ac.kr:query timed out,checkpatch.pl:query timed out,hartkopp.net:query timed out];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[checkpatch.pl:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,snu.ac.kr:email]

Hello Vincent!

On 06.05.26 12:22, Vincent Mailhol wrote:
> On Mon. 4 May 2026 at 13:31, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>> With commit 890e5198a6e5 ("can: raw: use bitfields to store flags in
>> struct raw_sock") the formerly separate integer values have been integrated
>> into a single bitfield. This led to a read-modify-write operation when
>> changing a flag in raw_setsockopt() which now needs a locking to prevent
>> concurrent access.
>>
>> Instead of adding a lock/unlock hell in each of the flag manipulations this
>> patch introduces a wrapper for a new raw_setsockopt_locked() function
>> analogue to the isotp_setsockopt[_locked]() approach in net/can/isotp.c
>>
>> Fixes: 890e5198a6e5 ("can: raw: use bitfields to store flags in struct raw_sock")
> 
> Arg, that's my patch, sorry for that!

No problem. I did realize this either o_O

>> Reported-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
> 
> Maybe add a link to the report?
> 
> Link: https://lore.kernel.org/linux-can/20260503112200.22727-1-eulgyukim@snu.ac.kr/

Good idea. In fact checkpatch.pl said "Reported-by: should be 
immediately followed by Closes: with a URL to the report"

So it should be

Closes: 
https://lore.kernel.org/linux-can/20260503112200.22727-1-eulgyukim@snu.ac.kr/

>> Tested-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> I was able to trigger the bug locally using Eulgyu minimum reproducer
> and I can confirm that the issue is correctly resolved by this patch.
> I also think that globally holding the lock simplifies the logic. I
> tried to think if there were any alternatives (like
> READ_ONCE()/WRITE_ONCE() or atomic types) but none of these seem
> applicable here.
> 
> Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
> Tested-by: Vincent Mailhol <mailhol@kernel.org>

Thanks Vincent!

Best regards,
Oliver

