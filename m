Return-Path: <linux-can+bounces-6594-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABdSCnEgl2kJvAIAu9opvQ
	(envelope-from <linux-can+bounces-6594-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Feb 2026 15:38:41 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6337915FA3E
	for <lists+linux-can@lfdr.de>; Thu, 19 Feb 2026 15:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61A1D3030499
	for <lists+linux-can@lfdr.de>; Thu, 19 Feb 2026 14:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D27533F8DA;
	Thu, 19 Feb 2026 14:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="I0b0CWGg";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="NUB69xeL"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4829833F8A6;
	Thu, 19 Feb 2026 14:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.162
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771511767; cv=pass; b=aR8UBOzJSJo4CLYQ/y0vSMDkPHBrJquo8uH7YSdacUOUAgRh9rmu2IPPifTj08iIQQ2pT/hdPv/5NB/7EDx+kmLUvhyZQpOSPLLf1OsXiBAHpPk4pDHP8auHLBJITPGqsMVt6xK7jU6FrJf355U6eXS23b+/xu8yQYV/rFBMAZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771511767; c=relaxed/simple;
	bh=X0j4Rkl3W1GfwxlZRelHXqRgiQ7qmofnsgKn+nZ2zE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZdfjOLA7EW8a9QzXYJFM7uw5Aa42TkBkOb9IiIdGxy7GSzGuSFZ6/dX0Vka/XGIc6ZypnLH4VMA7tkC4KC1fUjRAzc9wYU79HSjkmr++4HRMWR47+MxY7MUTUukvpWtUinpbD3jR8O331m7aTvHJln+gE1XWYAAlAqT/wiVoE30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=I0b0CWGg; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=NUB69xeL; arc=pass smtp.client-ip=81.169.146.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1771511032; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=TUvBc3O91LrYo1yU+YU9yJ9l5f6wceDuu3ICiiPHu01AMtfaex7WGYRrjp7QKQIo8j
    qk+uN+Oa0wlFYXDQQt2UeZpILmYtJRGdZA11MJBU0yUFAr2whYZAVnAkggRvxcdlY9Wv
    fg4Tma0gehq2lOP9p8WhFCLpw4ZboM/ucg3RiiUaz8c2vuVmYefRYzNkXfCyWMTgLP/H
    7dkNOWaUulp9QVeKrBEzL1l4EI3mRboZAlz1SLu8ZZfhVImoZAeb+nvYZiZv/CMDrcSk
    94wXQaWd8cuWc40WaTo2cJxbwSFnMpILSVv9ZrolwD8glPw0CunDNUkTnfFPVqEsieys
    5+pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1771511032;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=zfkkuJHTV+eajK/COfm2/MpRvjA0J3x9aV8N9C+xqyM=;
    b=pZq2Gu0cTIxStYfATSR3RzwD2KFFUXHZJlXksI4NaaWlgYAKYkOR89Z+aHQgbSmsGd
    qbUphcE1ZihUamG859Q5RV2qZpR9NPoQuyCxQDteT0eTI29RQrVNbRb2dNfI4+YURQb4
    kTC4AlyMmnxBE1RhKuw29+F90Q7ujlFtpOwPfDWyEnBZJ7mpElkkUaYKWLG/UayfQp4s
    UY5Q4JORU/AIcJxoonVbr1FgJm3Dx68vCw9CM0+gPRMeiHbVwB02YvMfBm7Q5wTBJYgF
    R3LUdnqCTBou7C0AlB9KRTtRVY1MfGygNT6OOUOsWWbEkrh6o1WDUx1LY+uFfGURzhoT
    yW6A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1771511032;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=zfkkuJHTV+eajK/COfm2/MpRvjA0J3x9aV8N9C+xqyM=;
    b=I0b0CWGg25nVE2dRuBe8XhsVY4QQrILN5QtvEfQFTY4hM9kBhryGlWoGuZN1dUL/nV
    ix3rVCTi3G+nDMqZhxX7CWHdptGhIzFE9pXOAei2TKMNi8e9pL+OePa7HDsNtQRuhF67
    CCgnP06cvJekOZojOKUpfNGbieg+U9Lg322hlfVc+hhrMAbzjv5r3n/CHfw72hi4rB4U
    fe1PqX15FTRXycltGDHKaguScwVvQfAdZuPSmdNxWnbWPCOEZOHMjStLvOYq7IDneJta
    GkkTR51kHjpvbkcae1QA8+7mh8BoU1OXEK1FNzhib3ACKjU2B7gLpiZmMofxHSDhUYOj
    rAhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1771511032;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=zfkkuJHTV+eajK/COfm2/MpRvjA0J3x9aV8N9C+xqyM=;
    b=NUB69xeLTftcntmI249G5jFWjtG2M+ajXv9b/VFltSk8tdI5mgH7IBafFoJq8vWflk
    hKq42TjzszyexQXIGNAA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s0ZDT0tksFSR+Aix0esQJVIAlZEg=="
Received: from [IPV6:2a00:6020:4a38:6800:217d:dfe3:b063:ecb0]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Ka861021JENqTqA
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 19 Feb 2026 15:23:52 +0100 (CET)
Message-ID: <48f1ee82-c1f7-4cfc-b916-b6a1d71c79ce@hartkopp.net>
Date: Thu, 19 Feb 2026 15:23:47 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] can: bcm: add locking when updating filter and
 timer values
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>,
 Urs Thuermann <urs.thuermann@volkswagen.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+75e5e4ae00c3b4bb544e@syzkaller.appspotmail.com
References: <20260219-bcm_spin_lock_init-v2-0-694352bfca62@hartkopp.net>
 <20260219-bcm_spin_lock_init-v2-2-694352bfca62@hartkopp.net>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260219-bcm_spin_lock_init-v2-2-694352bfca62@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6594-lists,linux-can=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,75e5e4ae00c3b4bb544e];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hartkopp.net:mid,hartkopp.net:dkim,hartkopp.net:email]
X-Rspamd-Queue-Id: 6337915FA3E
X-Rspamd-Action: no action



On 19.02.26 13:47, Oliver Hartkopp via B4 Relay wrote:
> From: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> KCSAN detected a simultaneous access to timer values that can be
> overwritten in bcm_rx_setup when updating timer and filter content.
> This caused no functional issues in the past as the new values might
> show up at any time without losing its intended functionality.
> 
> Btw. the KCSAN report can be resolved by protecting the 'lockless'
> data updates with a spin_lock_bh().
> 
> Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")
> Reported-by: syzbot+75e5e4ae00c3b4bb544e@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-can/6975d5cf.a00a0220.33ccc7.0022.GAE@google.com/
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>

The bcm KCSAN splats have gone with this patch.

Best regards,
Oliver

> ---
>   net/can/bcm.c | 39 ++++++++++++++++++++++++++++++++-------
>   1 file changed, 32 insertions(+), 7 deletions(-)
> 
> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index fd9fa072881e..0a3dc5500e14 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -123,10 +123,11 @@ struct bcm_op {
>   	struct canfd_frame sframe;
>   	struct canfd_frame last_sframe;
>   	struct sock *sk;
>   	struct net_device *rx_reg_dev;
>   	spinlock_t bcm_tx_lock; /* protect currframe/count in runtime updates */
> +	spinlock_t bcm_rx_update_lock; /* protect update of filter data */
>   };
>   
>   struct bcm_sock {
>   	struct sock sk;
>   	int bound;
> @@ -1141,10 +1142,12 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
>   		return -EINVAL;
>   
>   	/* check the given can_id */
>   	op = bcm_find_op(&bo->rx_ops, msg_head, ifindex);
>   	if (op) {
> +		void *new_frames = NULL;
> +
>   		/* update existing BCM operation */
>   
>   		/*
>   		 * Do we need more space for the CAN frames than currently
>   		 * allocated? -> This is a _really_ unusual use-case and
> @@ -1152,33 +1155,53 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
>   		 */
>   		if (msg_head->nframes > op->nframes)
>   			return -E2BIG;
>   
>   		if (msg_head->nframes) {
> -			/* update CAN frames content */
> -			err = memcpy_from_msg(op->frames, msg,
> +			/* get new CAN frames content before locking */
> +			new_frames = kmalloc(msg_head->nframes * op->cfsiz,
> +					     GFP_KERNEL);
> +			if (!new_frames)
> +				return -ENOMEM;
> +
> +			err = memcpy_from_msg(new_frames, msg,
>   					      msg_head->nframes * op->cfsiz);
> -			if (err < 0)
> +			if (err < 0) {
> +				kfree(new_frames);
>   				return err;
> -
> -			/* clear last_frames to indicate 'nothing received' */
> -			memset(op->last_frames, 0, msg_head->nframes * op->cfsiz);
> +			}
>   		}
>   
> +		spin_lock_bh(&op->bcm_rx_update_lock);
>   		op->nframes = msg_head->nframes;
>   		op->flags = msg_head->flags;
>   
> +		if (msg_head->nframes) {
> +			/* update CAN frames content */
> +			memcpy(op->frames, new_frames,
> +			       msg_head->nframes * op->cfsiz);
> +
> +			/* clear last_frames to indicate 'nothing received' */
> +			memset(op->last_frames, 0,
> +			       msg_head->nframes * op->cfsiz);
> +		}
> +		spin_unlock_bh(&op->bcm_rx_update_lock);
> +
> +		/* free temporary frames / kfree(NULL) is safe */
> +		kfree(new_frames);
> +
>   		/* Only an update -> do not call can_rx_register() */
>   		do_rx_register = 0;
>   
>   	} else {
>   		/* insert new BCM operation for the given can_id */
>   		op = kzalloc(OPSIZ, GFP_KERNEL);
>   		if (!op)
>   			return -ENOMEM;
>   
>   		spin_lock_init(&op->bcm_tx_lock);
> +		spin_lock_init(&op->bcm_rx_update_lock);
>   		op->can_id = msg_head->can_id;
>   		op->nframes = msg_head->nframes;
>   		op->cfsiz = CFSIZ(msg_head->flags);
>   		op->flags = msg_head->flags;
>   
> @@ -1261,24 +1284,26 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
>   
>   	} else {
>   		if (op->flags & SETTIMER) {
>   
>   			/* set timer value */
> +			spin_lock_bh(&op->bcm_rx_update_lock);
>   			op->ival1 = msg_head->ival1;
>   			op->ival2 = msg_head->ival2;
>   			op->kt_ival1 = bcm_timeval_to_ktime(msg_head->ival1);
>   			op->kt_ival2 = bcm_timeval_to_ktime(msg_head->ival2);
> +			op->kt_lastmsg = 0;
> +			spin_unlock_bh(&op->bcm_rx_update_lock);
>   
>   			/* disable an active timer due to zero value? */
>   			if (!op->kt_ival1)
>   				hrtimer_cancel(&op->timer);
>   
>   			/*
>   			 * In any case cancel the throttle timer, flush
>   			 * potentially blocked msgs and reset throttle handling
>   			 */
> -			op->kt_lastmsg = 0;
>   			hrtimer_cancel(&op->thrtimer);
>   			bcm_rx_thr_flush(op);
>   		}
>   
>   		if ((op->flags & STARTTIMER) && op->kt_ival1)
> 


