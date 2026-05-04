Return-Path: <linux-can+bounces-7468-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMNjEtwb+GnCpwIAu9opvQ
	(envelope-from <linux-can+bounces-7468-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 04 May 2026 06:09:00 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0984B84BF
	for <lists+linux-can@lfdr.de>; Mon, 04 May 2026 06:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C0142300F19C
	for <lists+linux-can@lfdr.de>; Mon,  4 May 2026 04:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E996239E9A;
	Mon,  4 May 2026 04:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="rIuZW8a4"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B6440DFD1
	for <linux-can@vger.kernel.org>; Mon,  4 May 2026 04:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777867729; cv=none; b=Q6JO7+af3d9wK0EjLCofjHcAl2vyusV0ChmVfuwCIIk2BFGKGVRL5NWzedQ2tbiFPAZJayMeZj1DXiM3Kfs5zabcBUR45qLPKqNXmL66O95kehbG8VD4C9f/xAJwGBEr31my/rz9/OFPNmwIc3/Ac1aC2M1c5CopoTOyp8BUUFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777867729; c=relaxed/simple;
	bh=PinL4ABuvHZvmktbwsxLCvN1uTYFRvo5pGKLiAs7eXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZZ7iZjmecACRYg/24enkOrzRlOdjPAIWQw1hGY/kpFeyrHVdaS1nMfxqh2Kzsx84hp3uLLu7bxwsIOWRKP+9PHLIAJ1Xg2nB7AQZIyJN6+phaTdWQrE0e2dX6QSMEZUQNuKGW+k4zRaVjxjKTbCGdeiacYHPVj9F8rmUkCHNyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=rIuZW8a4; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c80227c9572so146338a12.2
        for <linux-can@vger.kernel.org>; Sun, 03 May 2026 21:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1777867724; x=1778472524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8tsf4b2nAsqwqcVa1KFYp7i08w/B4bBOL9vjlWUDhQ=;
        b=rIuZW8a4o6KXLmd9Q0lCZfpY9QIo5fFULf9+JN338TTV/4sgRpGekig2lTUMpBNr/4
         CpBlPZNfl5UgH5vMTehMH/w0uUuRbK0qjiRpqlICo5q2G7vUfzRA6dr7aBf3ldHzu/fG
         hh1b3zgoN34xdj75PQHK4B1G0YNRFxDNmioL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777867724; x=1778472524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X8tsf4b2nAsqwqcVa1KFYp7i08w/B4bBOL9vjlWUDhQ=;
        b=ka8IOCFe6JWJ9jgmauKVLU1xyLUAp85OChOT7MbZdm9ttOzVIt0BIb6efVhBDQq1vr
         GRtPMrdN99WkMja9rNxLc8cieCvDjJ/sQAken8XGkkgPoFBZWInfvuw3BYhJwU1uLFlJ
         MlSveyxPnhGIjwCoDkyGQuk7tLc08k/4A6ACGppOf1p1cV8mTxjUFjmWeXWsvHT9zQ3X
         QEKsJzHY8zuGLFMmqt1pLw90FD1z2adfvvdhvg2DNa8s/c0LZpuJsb0uV+OE9VlnIt3+
         M0hodV6me8v4KkKVfyNJl8Rq3r98EtlyWted8+ljo7tGcU0Qh6jAWPi6xjKvHuHJqSi+
         pCYA==
X-Forwarded-Encrypted: i=1; AFNElJ+UUw+MHEcY/iJ6kdapVhSxeQDpU9bffcwrslmlYlKK9Tx389Tl5Mpg0r3xYHZLJnLWfeoaQrSTzEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCjuv1PmFGBI0qnD4GZ75OVYwN8yui6KyN9Mw9NFDu6U8tOOK6
	YS/612QMJem1TVLbHtWaOX7i86x8sod+8ALnfSvVjEdSxyLmB/Va+Zn6Q28Ld5mpl0E=
X-Gm-Gg: AeBDieslC+NUhtsn9Iu19NPj/PC96n3yxm1AHRyy7zuM3uQAtharKJhI4CzaH01NA2a
	SbwNfS3UnU0HWJCWgdzr09lXGiL698vEexifjE9VHppLz+Y32L2T4w6/pLbbKt/cCt0lXy/OSiz
	AYSofI0VePovdU3jdnqiu/2cpspNgSRQm2xDhDEDNZEJJdWGZxPPQ0P5Qh0X0AqrPNM7tS4DtPs
	CyUGXFy6Zf2PqucZPbtvtP/w/t/0SbuEdE1inIZlE7mI+g/PYqIWgLZ5vXxSR3hNde467bUlPgM
	wbhDxqj5Okg9OjO0uLg6ATENoaOApB7z8VNqgWnKpBYB7RFRtBIdsw3HtoB3+dI4oQ5nS3dl8rA
	04+sXB21jW2LzIFmrAa0Q0s2yq2NB7it0B1V2woEIdHa195n4e14MCRFE8yJThwyX+aKMo00wIZ
	T6dphD4fMcmS7zEJNHS0VGOR39C9p8fINw1EuOlTiqZJoryInJCmCTKujcqYi39SGVVRLAFYGfM
	kVGFCzlkUSR
X-Received: by 2002:a17:902:ea09:b0:2b0:608d:d8a8 with SMTP id d9443c01a7336-2b9f256e5a6mr69413095ad.1.1777867724034;
        Sun, 03 May 2026 21:08:44 -0700 (PDT)
Received: from eulgyu-desktop.localdomain ([147.46.174.223])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caa8a0d9sm88711965ad.9.2026.05.03.21.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 21:08:43 -0700 (PDT)
From: Eulgyu Kim <eulgyukim@snu.ac.kr>
To: socketcan@hartkopp.net
Cc: mkl@pengutronix.de,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	byoungyoung@snu.ac.kr,
	jjy600901@snu.ac.kr
Subject: Re: [BUG] KASAN: slab-use-after-free Read in raw_rcv
Date: Mon,  4 May 2026 13:08:39 +0900
Message-ID: <20260504040839.20805-1-eulgyukim@snu.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <c744de46-14b3-4902-bf36-50492992007f@hartkopp.net>
References: <c744de46-14b3-4902-bf36-50492992007f@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0B0984B84BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[snu.ac.kr,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[snu.ac.kr:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[snu.ac.kr:+];
	TAGGED_FROM(0.00)[bounces-7468-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eulgyukim@snu.ac.kr,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

> >
> > Can you confirm that the below patch fixes the issue?
> >
> > Best regards,
> > Oliver
> >
> > diff --git a/net/can/raw.c b/net/can/raw.c
> > index a26942e78e68..48d1bf297c2c 100644
> > --- a/net/can/raw.c
> > +++ b/net/can/raw.c
> > @@ -697,49 +697,68 @@ static int raw_setsockopt(struct socket *sock, int
> > level, int optname,
> >               return -EINVAL;
> >
> >           if (copy_from_sockptr(&flag, optval, optlen))
> >               return -EFAULT;
> >
> > +        rtnl_lock();
> > +        lock_sock(sk);
> >           ro->loopback = !!flag;
> > +        release_sock(sk);
> > +        rtnl_unlock();
> >           break;
> >
> >       case CAN_RAW_RECV_OWN_MSGS:
> >           if (optlen != sizeof(flag))
> >               return -EINVAL;
> >
> >           if (copy_from_sockptr(&flag, optval, optlen))
> >               return -EFAULT;
> >
> > +        rtnl_lock();
> > +        lock_sock(sk);
> >           ro->recv_own_msgs = !!flag;
> > +        release_sock(sk);
> > +        rtnl_unlock();
> >           break;
> >
> >       case CAN_RAW_FD_FRAMES:
> >           if (optlen != sizeof(flag))
> >               return -EINVAL;
> >
> >           if (copy_from_sockptr(&flag, optval, optlen))
> >               return -EFAULT;
> >
> > +        rtnl_lock();
> > +        lock_sock(sk);
> >           /* Enabling CAN XL includes CAN FD */
> > -        if (ro->xl_frames && !flag)
> > +        if (ro->xl_frames && !flag) {
> > +            release_sock(sk);
> > +            rtnl_unlock();
> >               return -EINVAL;
> > +        }
> >
> >           ro->fd_frames = !!flag;
> > +        release_sock(sk);
> > +        rtnl_unlock();
> >           break;
> >
> >       case CAN_RAW_XL_FRAMES:
> >           if (optlen != sizeof(flag))
> >               return -EINVAL;
> >
> >           if (copy_from_sockptr(&flag, optval, optlen))
> >               return -EFAULT;
> >
> > +        rtnl_lock();
> > +        lock_sock(sk);
> >           ro->xl_frames = !!flag;
> >
> >           /* Enabling CAN XL includes CAN FD */
> >           if (ro->xl_frames)
> >               ro->fd_frames = ro->xl_frames;
> > +        release_sock(sk);
> > +        rtnl_unlock();
> >           break;
> >
> >       case CAN_RAW_XL_VCID_OPTS:
> >           if (optlen != sizeof(ro->raw_vcid_opts))
> >               return -EINVAL;
> > @@ -758,11 +777,15 @@ static int raw_setsockopt(struct socket *sock, int
> > level, int optname,
> >               return -EINVAL;
> >
> >           if (copy_from_sockptr(&flag, optval, optlen))
> >               return -EFAULT;
> >
> > +        rtnl_lock();
> > +        lock_sock(sk);
> >           ro->join_filters = !!flag;
> > +        release_sock(sk);
> > +        rtnl_unlock();
> >           break;
> >
> >       default:
> >           return -ENOPROTOOPT;
> >       }
> >
> >

Hello,

thanks for your reply.

We have tested the patch, and our reproducer did not trigger any issue.

As this issue was identified via fuzzing and we have limited background,
we find it challenging to provide further verification.

At least for our specific test case, the issue seems to be resolved.

We hope this testing feedback is helpful.

Thank you.

Best Regards,
Eulgyu Kim

