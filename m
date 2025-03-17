Return-Path: <linux-can+bounces-3115-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB28A6492E
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 11:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44CD517322B
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 10:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCC123A985;
	Mon, 17 Mar 2025 10:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eIjI5EG0"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA80423A564
	for <linux-can@vger.kernel.org>; Mon, 17 Mar 2025 10:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206448; cv=none; b=htUAyInfML5xirflSWVsCR8DlrN5ln7tajM0H6z3Hi9/F+enmu978hATkFX/S2zkHlzBUTae2KexrufVnk1J9D1RxSwHV6qvICku1+nIU9ilDFhgWcWHuzcfH4AUXJLU2qmMN2dk5kDITzHdEIZfy0SFhiCfeAitzbUh181V2mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206448; c=relaxed/simple;
	bh=nt4FCE011lsz6inGNdNl00vU8hDqQ/dilJWUR3cGgSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTlwWsUPiP6TnxwRdlTcSwqIX6o2aFTdMRMzsp40y2sdZ3qqqG+oo0op9Q33plLrhwqjaOjuQ+UbnOZBxwjHrSEt4Iw1cngoDfgx5I8fLLGQD+ptRmOL5gfNRtvLZUQELoYbJKtNM2gTb/cXKV3B1quXlPsjOpSyGQToaa9O6ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eIjI5EG0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742206445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5T0oTp+OSOt7rSkWZPtxHsCLsZC1ZKCnWcixEW7NGFY=;
	b=eIjI5EG0XcivcZ8AThLsXWlYZaLya7e0rzRBGMq1Ak4oyBExCFo8TUwxhe6u4IlDTqpCHi
	/WQf+I5VTHLD169g2fQ0GWAiza8maHnmIvmXSm7OHvfd38deO6TzWg1sNEtApGdxK9i4wE
	uWKJHx90fbrfuYHGi+/G6zuMI6dCXjM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-Io3pQNkwM2Ga2VwLDzzB4Q-1; Mon, 17 Mar 2025 06:14:04 -0400
X-MC-Unique: Io3pQNkwM2Ga2VwLDzzB4Q-1
X-Mimecast-MFC-AGG-ID: Io3pQNkwM2Ga2VwLDzzB4Q_1742206443
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43cec217977so14048335e9.0
        for <linux-can@vger.kernel.org>; Mon, 17 Mar 2025 03:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742206442; x=1742811242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5T0oTp+OSOt7rSkWZPtxHsCLsZC1ZKCnWcixEW7NGFY=;
        b=UnwadP/YRdoJYXwRY0lfp03RY6NxQWr7FJNQbj0F1+zI+Mqn5RgBeXctb9ttq9idkh
         FBT8ZXTJy1hnXmAp+TBNrbr5k98rPctmWbNT+jLGKZLjtXfPdXSgZCQVShCgOMO10UH1
         TE+iJj3ANFuRmDHmEVc4tc/EC1Dy0wQ/3Q+xh1zOjSgI3nN1TJhSq1QPaox6j3joDyjW
         jADoFKAZJ/EBfJhcHKX50Di0KuOH616OwRGFAMOc4dctn7CB7xssMFY0Gv8KTvghPd7c
         8Js0E5pdNGDRGNUE0u72SXvyZrpD5gHrVqLE6LPJGj3TssZG2gGWaUSYCCaxVEa0meGD
         Gz+w==
X-Forwarded-Encrypted: i=1; AJvYcCXH1youBdnhupmkkzE9VAxgsy6u2rN//ZezWh7IMPFGFli899qoC1TLyaNxry/s6zjk7yLgGKaoUgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4exW2RGplRJQxn9De7ajMd/8aZkfD364EIRrR3OS9uiCCLQXZ
	BfKdcKVAieQvx51mqBpjL0mhccgfMN6v4pO//zcHLeLc43p2LPtu/Jvk9WdbSo6H7qpSJy/A+Tz
	QLePs9TrLWC++SrMo03hOMmde+J7EtKpYug8MEZQ/yAhoHMJuxB9giX6DxrjvK4A3YSuB
X-Gm-Gg: ASbGnctMzl8m18Ov3UEbjq0TCA472oAQngyhpuU1YI80u5ZK78PpSkSe439s0+/qH/9
	qJ8HoFtSBKVpxtLQ4NxljmULmDfQLO7YuE+xYiBFCmpayxkQ2G1QR84v7K0vSavBW0hovG/mGcr
	PpCeWsdNlA3im/10gjENuWV+E2M+hghcl1cI/ylIBafkLsMxobFuZIu5Tw0MoloMnuET10e83tE
	LxHhBtM6rnHZ1Vs0zO2X649eTDiVSbGILOIB1iWqJb5l3FzLBroCdJhT4aK+iwDWl0FdPgKQRbl
	B5Km8flvP7j1sg==
X-Received: by 2002:adf:e04d:0:b0:391:2d61:453f with SMTP id ffacd0b85a97d-3971ef3b428mr10041463f8f.24.1742206442549;
        Mon, 17 Mar 2025 03:14:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoLNrNq/NqPlLo/ejzn1SmE/uMJl7tgVxJdhVSkYJ68Yr/dGGixV+YByKi+Cu+Ch5IanmxLg==
X-Received: by 2002:adf:e04d:0:b0:391:2d61:453f with SMTP id ffacd0b85a97d-3971ef3b428mr10041440f8f.24.1742206442191;
        Mon, 17 Mar 2025 03:14:02 -0700 (PDT)
Received: from localhost ([2a01:e11:1007:ea0:8374:5c74:dd98:a7b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb318a75sm14611868f8f.76.2025.03.17.03.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 03:14:01 -0700 (PDT)
Date: Mon, 17 Mar 2025 11:14:00 +0100
From: Davide Caratti <dcaratti@redhat.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Subject: Re: [PATCH] can: add protocol counter for AF_CAN sockets
Message-ID: <Z9f16MYRF_vlkkVY@dcaratti.users.ipa.redhat.com>
References: <9db5d0e6c11b232ad895885616f1258882a32f61.1741952160.git.dcaratti@redhat.com>
 <78951192-82b1-45bc-9903-d314c94cd182@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78951192-82b1-45bc-9903-d314c94cd182@hartkopp.net>

thanks for reviewing!

On Sun, Mar 16, 2025 at 01:36:40PM +0100, Oliver Hartkopp wrote:
> Hello Davide,
> 
> thanks for your patch!

ouch, I forgot j1939. I had a selftest for that, but I could only
test raw.

> But don't we need to take care on every place where sock_put() is called
> where sock_prot_inuse_add() has to decrease the counter?

only the last call to sock_put() needs sock_prot_inuse_add(..., -1):

[...]

> ~/linux/net/can$ git grep sock_put .
> af_can.c:               sock_put(sk);

167         if (sk->sk_prot->init)
168                 err = sk->sk_prot->init(sk);
169
170         if (err) {
171                 /* release sk on errors */
172                 sock_orphan(sk);
173                 sock_put(sk);
174                 sock->sk = NULL;
175         } else {
176                 sock_prot_inuse_add(net, sk->sk_prot, 1);
177         }

^^ this one does not need it because the 'in_use' counter is incremented
in the else branch; 

> af_can.c:               sock_put(sk);

491 static void can_rx_delete_receiver(struct rcu_head *rp)
492 {
493         struct receiver *rcv = container_of(rp, struct receiver, rcu);
494         struct sock *sk = rcv->sk;
495
496         kmem_cache_free(rcv_cache, rcv);
497         if (sk)
498                 sock_put(sk);
499 }

this one comes from can_rx_unregister(), and it's called in RCU callback - so
we can't tell if it happens before or after sock_put() in ->release().
So we probably need something smarter in case we are not sure that ->release()
is called at least once for each socket. 

> bcm.c:  sock_put(sk);
> isotp.c:        sock_put(sk);
> raw.c:  sock_put(sk);

this is  '->release()' of each protocol, that I aimed to cover in the
patch...

> j1939/socket.c: sock_put(sk);
> j1939/transport.c:      sock_put(session->sk);

... except this one, that I forgot :) 

I will send a follow-up patch soon.
Thanks!
-- 
davide


