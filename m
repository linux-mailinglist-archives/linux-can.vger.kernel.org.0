Return-Path: <linux-can+bounces-6586-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBxbLpcAl2mItQIAu9opvQ
	(envelope-from <linux-can+bounces-6586-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Feb 2026 13:22:47 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8F615E925
	for <lists+linux-can@lfdr.de>; Thu, 19 Feb 2026 13:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E13F93025F43
	for <lists+linux-can@lfdr.de>; Thu, 19 Feb 2026 12:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF23D30BF4F;
	Thu, 19 Feb 2026 12:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="lp9Hzwuf";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="JZ3O+25u"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B2733123A
	for <linux-can@vger.kernel.org>; Thu, 19 Feb 2026 12:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771503761; cv=pass; b=m4DJ9H499up1s+ug+/xGIM0p++KssdMSTzvUMcsqlijuKiJPZ65DvsYmyo12CLStyjzgagC4Es7hgKssmw1y7VlbEcIPdb4U9YxKs5OCba1uHN121prw9njEPXR7cnAFdPuIVfVN9UIwRiYoGIKgRSoich6VuEch9fmDzBdmRP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771503761; c=relaxed/simple;
	bh=fmJyyIkJ50wDy1q9WNhEkRT7SRhnLav5jpNRwwTo+jk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ifji4a1uPcmHMP6ktwI+qvPwO+6lTmLr1i/AOw+JW0UF2+4sT+JxSpOXdFdb4+yUeLgyfzoMD9puj/tvkLf9B9Bu5CXi/fRi8XyKwqeuvXw49MObHlfV7xn60opj0lkh04kRSPkMiCYyhDVfFwEdcbOTlcnQyf6FZNrkEGu9g+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=lp9Hzwuf; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=JZ3O+25u; arc=pass smtp.client-ip=81.169.146.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1771503750; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=aDUThcdGRhh9dsRnRnzzpxr+OuXNz3krDvW/U+wTjBS4sv71q3qngsORWW/e0AkStr
    sQ/8rjOve+WBqN9mKUbXgfs21m3uuNeuuxw0j7zflScxUUz5Y9jPnQDZDlN1x200rA2A
    dIm75x8/MKapnpVZiJpmyaQy26ERyB62TSMDiv9g07ltZ9wG1yDTcxn+qMMpp5g05ZS9
    NRI6A4dCWsry60LtB+taWJvwnJCKnKNwby0tOIUrjgfUOG/rePJbrWUbZnrlHEMW445m
    b5cBn+o4LntS2ZTbLky8Ca6pnqm9k+CVfDOCgbBB0pCfrf8kGqQYIp091ceHXAdNIKFz
    KMJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1771503750;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=hNZuiVckrvMMAjQvgqdZ+WbmyNe+KrIqm4p0zv/6BD0=;
    b=qGEkDMGewCrZfnUvyvesP35RV/5l7uk2opQn3tOjv7gQJyZeVj7Yj1rD65Tls5/gN3
    Xnnk18jYTDex/Zr726BX1RkdS6wtoeWk7GrMaOHFxqM3YY8DX83SkJDEJXHg44GR7uKM
    XRdCEFObZegkV6/UH+Nz4iqAa7DxvjFHINaqcXWOmE/6ry9ow2lwDuf5BjRqtPRCLvYY
    wev+sF0EBYbInhBGCvKWyM3EBNNLk8PN13tPicIgBJ4nKOanTifUuN7pH68sHmd91L9i
    9OY3gxAO+ZPSYVlBU9eoPR1K5N8qxmqhTHtMZre+eDO3hIGhQgXRdaWM2XQZICVPRmH8
    zmbQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1771503750;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=hNZuiVckrvMMAjQvgqdZ+WbmyNe+KrIqm4p0zv/6BD0=;
    b=lp9Hzwufsmexy7GD4/+lRv7l8PdGyYa+VcrpBcCy2OhBlfqEND4o6v6O/RjX9KUHd8
    lNU8fa8icdYGEUPm2sAIPTRMtzj7N29KxWlXRrvkcbtXQLfFMiqRR7QPIUPvx25me7+K
    tRCPZQ961XRXMp7ZHbQq2BPcLOU+tbjlmS7WkZxyTaxcqf5PK1LL4u8t+g+VHyoOVyXE
    HBZVOrwM6i4CoFvr5DafjI+MtmfKwvrK/mt1XqkxlePoqaIA4xWckQivGMOA72ObOghA
    D9pht9zEhUnPaq97FbmhoEpWfuK0eWMWN73/PKHG3pstBmBogskoB+bYGCcRqugDX4pl
    FWuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1771503750;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=hNZuiVckrvMMAjQvgqdZ+WbmyNe+KrIqm4p0zv/6BD0=;
    b=JZ3O+25uC9MXXnA42k5obKGPdeUrONebf7bcArmpWUfti8jRKfZQP9HDwv7L1/LadU
    5JnH67WeTO04NpMVgfCw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s0ZDT0tksFSR+Aix0esQJVIAlZEg=="
Received: from [IPV6:2a00:6020:4a38:6800:217d:dfe3:b063:ecb0]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Ka861021JCMUTDJ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 19 Feb 2026 13:22:30 +0100 (CET)
Message-ID: <bd8fa6fc-3858-4b55-b186-aa5c773e19fa@hartkopp.net>
Date: Thu, 19 Feb 2026 13:22:29 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: bcm: fix locking for bcm_op runtime updates
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org
References: <20260218-bcm_spin_lock_init-v1-1-592634c8a5b5@hartkopp.net>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260218-bcm_spin_lock_init-v1-1-592634c8a5b5@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6586-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hartkopp.net:mid,hartkopp.net:dkim,hartkopp.net:email,appspotmail.com:email]
X-Rspamd-Queue-Id: 5F8F615E925
X-Rspamd-Action: no action

I have an updated patch for the bcm_rx_setup() issue using 
spin_lock_bh() too.

So this patch
https://lore.kernel.org/linux-can/20260126161711.2374-1-socketcan@hartkopp.net/
will be superseded too.

Best regards,
Oliver

ps. will send a b4 v2 patch set later


On 18.02.26 11:58, Oliver Hartkopp via B4 Relay wrote:
> From: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> Commit c2aba69d0c36 ("can: bcm: add locking for bcm_op runtime updates")
> added a locking for some variables that can be modified at runtime when
> updating the sending bcm_op with a new TX_SETUP command in bcm_tx_setup().
> 
> Usually the RX_SETUP only handles and filters incoming traffic with one
> exception: When the RX_RTR_FRAME flag is set a predefined CAN frame is
> sent when a specific RTR frame is received. Therefore the rx bcm_op uses
> bcm_can_tx() which uses the bcm_tx_lock that was only initialized in
> bcm_tx_setup(). Add the missing spin_lock_init() when allocating the
> bcm_op in bcm_rx_setup() to handle the RTR case properly.
> 
> Fixes: c2aba69d0c36 ("can: bcm: add locking for bcm_op runtime updates")
> Reported-by: syzbot+5b11eccc403dd1cea9f8@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-can/699466e4.a70a0220.2c38d7.00ff.GAE@google.com/
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>   net/can/bcm.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index b7324e9c955b..fd9fa072881e 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -1174,10 +1174,11 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
>   		/* insert new BCM operation for the given can_id */
>   		op = kzalloc(OPSIZ, GFP_KERNEL);
>   		if (!op)
>   			return -ENOMEM;
>   
> +		spin_lock_init(&op->bcm_tx_lock);
>   		op->can_id = msg_head->can_id;
>   		op->nframes = msg_head->nframes;
>   		op->cfsiz = CFSIZ(msg_head->flags);
>   		op->flags = msg_head->flags;
>   
> 
> ---
> base-commit: 2961f841b025fb234860bac26dfb7fa7cb0fb122
> change-id: 20260218-bcm_spin_lock_init-2518eb8d4501
> 
> Best regards,
> --
> Oliver Hartkopp <socketcan@hartkopp.net>
> 
> 


