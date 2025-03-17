Return-Path: <linux-can+bounces-3148-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29817A65692
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 16:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D02A9189C3B7
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 15:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F45719ABAB;
	Mon, 17 Mar 2025 15:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VnrzyOsf"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4085119AD5C
	for <linux-can@vger.kernel.org>; Mon, 17 Mar 2025 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742226614; cv=none; b=BXHtq5YWu9fldnXLZfEYLcK6gvTAO3433s7gs4ZFVkaA18xT2qT84nR/8KKpr+Aa+eFQFFZykmteEnd52dQrEOXfD1tmbDq5kPG55epGdjCyX9Aa1EcsGU3ap2ciLu2BKDzmsfuG9MhGT9pauJIj40KqxjFar64jduJ6LPsxvZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742226614; c=relaxed/simple;
	bh=+jsXUXsNhU8tYFhj80qsL6lqk+NLDAweg7KcPvuivd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBkuJkx34WzqrWeC4NN9DChtJSKuPMVDIImWaYd9pX+uRjvFCHcFM3Nwq8p3uQo8pfdUrrSMTgGCU5S94Xg6eAMiK6ylkYYhZoGH16IE354+nS+F71ip9coZXSbGx98N+FjyIXAjCl0sZhViB46/BX4K54m+L4iuylhOik/ov7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VnrzyOsf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742226611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ON5mXt9+MGPLSgdLoJHuvKgzI2kCoio/ONcjOV1BUEc=;
	b=VnrzyOsfBq/+dqQLwsBL1xzN0lvk4yzFf+yzh3OA1bJcM+TvHirju09jwFL5q1AaCa0Y79
	X0EFh7cGdHUjLH/lrf156YSoe0Rnpsbt4VE2nmUDE9qTB5zDiDQURBC+dbY6wAJMbI4F9G
	bP/pAD99NymnWioWnHfIe93hObHHAlI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-WxVSDYvpPFyUERaQkYQmeA-1; Mon, 17 Mar 2025 11:50:07 -0400
X-MC-Unique: WxVSDYvpPFyUERaQkYQmeA-1
X-Mimecast-MFC-AGG-ID: WxVSDYvpPFyUERaQkYQmeA_1742226606
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-39123912ff0so2318676f8f.2
        for <linux-can@vger.kernel.org>; Mon, 17 Mar 2025 08:50:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742226606; x=1742831406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ON5mXt9+MGPLSgdLoJHuvKgzI2kCoio/ONcjOV1BUEc=;
        b=SXR927qqU4AoOKbunsrWPYHWh26w6uZd7uRXbWGaLhVY3Z+qZkmpPjiU8/CeuTxniF
         NSm2LPc0vOGocZQK+9HJnPJ1x5OZZH0x9vmvDmX/VrU4X8ruS3I9RlQ++rDA2Wo5ZXBJ
         BRF33Jekdt8yuCJ0MRU1DNVXojWNu/xSd2hMSZMVYnA8UZOAXQBgIPQnuODSGbUNTD8g
         ws2kG+IBgR9bNIkSSWSJPuI6HeXfGG8upY7oHzPSz+sTAYh2SKZhgj3OWQwQkLQScJR+
         WLYvmMRuvqMYmMKgD3jaX+yLC+/cvOq3F16Pr4w2JY23TAJoNn35VNJvXo7Rqp56UoMS
         42gw==
X-Forwarded-Encrypted: i=1; AJvYcCXcDQlmdceuxaq7g1aRYeVasEI9INXB9s6c/lBtLQeimRu5TExI+gHowcMXOMz0PgY3B3zh4ddfsNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpBQPf/2sMWO0nIBsM36OqO0eLsboZTEMsv7o2r+GBj1msTWiJ
	ZEZTBdeN6qPpkqBdUxFRmyCvoUjP1NjB4JP1H+ofcSVz+IygSM9B259Gru3EujNX/5Xk9Q3DdaH
	GRCmyPFMts3py8tDObHc9jWn3dvC6VoyTMCIapfruNdoF0Tkg5Su3van3bUaMRrrqF/gP
X-Gm-Gg: ASbGnctafDIbITKNsDfRc24cyvZ4qhzAqcLao0djWyqsXTIf0JZ54B3J0V+6DLs43F5
	ONDN9YRiRROEuY+Fu5/Kjj9/YWOjW+2Xjt91Ewr0jcLSTK/1ff0IEyPIlBIqY8dVonAebIQfz/J
	9GepA0HyEpZvA0c2ewLVPzRlWQEfNEoV335Rehn4dmXR5xJVgxH4a4RIEG+cMCNhuAqnOEUff8l
	1DuMiweGHnaBwhAsTsrVebFGExDWtVgeu00sFUNN6i39N3dF1Pxa6SI04+V5zcTGvGw1VCglm+n
	reDKMyQHsv9hyQ==
X-Received: by 2002:adf:a413:0:b0:394:7c55:7030 with SMTP id ffacd0b85a97d-3971e0bdc77mr8315576f8f.30.1742226605867;
        Mon, 17 Mar 2025 08:50:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSpiG1XUnayNucrvITHl0q751hDgfvdluSqTksUhmuP1HCEeGv1fOKUtfC9NgMCuy2Mo+cXA==
X-Received: by 2002:adf:a413:0:b0:394:7c55:7030 with SMTP id ffacd0b85a97d-3971e0bdc77mr8315559f8f.30.1742226605452;
        Mon, 17 Mar 2025 08:50:05 -0700 (PDT)
Received: from localhost ([2a01:e11:1007:ea0:8374:5c74:dd98:a7b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cbbc88f2sm15355857f8f.101.2025.03.17.08.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 08:50:04 -0700 (PDT)
Date: Mon, 17 Mar 2025 16:50:04 +0100
From: Davide Caratti <dcaratti@redhat.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Subject: Re: [PATCH] can: add protocol counter for AF_CAN sockets
Message-ID: <Z9hErDHczAhqds_Q@dcaratti.users.ipa.redhat.com>
References: <9db5d0e6c11b232ad895885616f1258882a32f61.1741952160.git.dcaratti@redhat.com>
 <78951192-82b1-45bc-9903-d314c94cd182@hartkopp.net>
 <Z9f16MYRF_vlkkVY@dcaratti.users.ipa.redhat.com>
 <fdcebcb4-f1d4-4fc8-82cf-62e1213538c0@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdcebcb4-f1d4-4fc8-82cf-62e1213538c0@hartkopp.net>

hi Oliver,

On Mon, Mar 17, 2025 at 11:21:25AM +0100, Oliver Hartkopp wrote:

> > > But don't we need to take care on every place where sock_put() is called
> > > where sock_prot_inuse_add() has to decrease the counter?
> > 
> > only the last call to sock_put() needs sock_prot_inuse_add(..., -1):
> 
> Right.

well, it does not even need to be the very last caller. Just +1 for each
socket created, -1 for each socket released. /proc/net/protocols counts the
number of active sockets for each protocol, so it's ok not to account for
dead / already-orphaned ones that are just waiting for being freed in some
later RCU callback - like it happens   See below:

[...]
 
> > > af_can.c:               sock_put(sk);
> > 
> > 491 static void can_rx_delete_receiver(struct rcu_head *rp)
> > 492 {
> > 493         struct receiver *rcv = container_of(rp, struct receiver, rcu);
> > 494         struct sock *sk = rcv->sk;
> > 495
> > 496         kmem_cache_free(rcv_cache, rcv);
> > 497         if (sk)
> > 498                 sock_put(sk);
> > 499 }
> > 
> > this one comes from can_rx_unregister(), and it's called in RCU callback - so
> > we can't tell if it happens before or after sock_put() in ->release().
> > So we probably need something smarter in case we are not sure that ->release()
> > is called at least once for each socket.
> 
> The can_rx_delete_receiver() might be called if the (e.g. USB) CAN interface
> is removed in the network notifier. So this is no gracefully socket
> termination from user space.
> I think the need to decrease the prot-in-use counter here too.

AFAIU sock_put() in can_rx_delete_receiver() is always balanced with
sock_hold() here:

564         /* schedule the receiver item for deletion */
565         if (rcv) {
566                 if (rcv->sk)
567                         sock_hold(rcv->sk);
568                 call_rcu(&rcv->rcu, can_rx_delete_receiver);
569         }

and we have can_rx_unregister() also in ->release(). So, I think it's OK not to
do sock_prot_inuse_add(..., -1) inside the RCU callback and just decrement the
after socket is orphaned. For similar reason, I think that 

252 static void __j1939_session_drop(struct j1939_session *session)
253 {
254         if (!session->transmission)
255                 return;
256 
257         j1939_sock_pending_del(session->sk);
258         sock_put(session->sk);
259 }

does not need to touch 'in_use' counter, because it couples with this:

2025         /* skb is recounted in j1939_session_new() */
2026         sock_hold(skb->sk);
2027         session->sk = skb->sk;

for a socket (namely skb->sk) that's already created.

[...]

> > this is  '->release()' of each protocol, that I aimed to cover in the
> > patch...
> > 
> ACK
> 
> > > j1939/socket.c: sock_put(sk);

bottom line, I think we only need one sock_prot_inuse_add(..., -1)
in the above file. WDYT?

thanks,
-- 
davide

(*) I'm planning to write a small module to add support for 'ss'
diagnostics on AF_CAN sockets. This patch was sort-of preparatory work
for kselftests :)


