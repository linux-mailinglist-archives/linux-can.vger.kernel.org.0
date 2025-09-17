Return-Path: <linux-can+bounces-4724-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8049EB7FF27
	for <lists+linux-can@lfdr.de>; Wed, 17 Sep 2025 16:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B046D58698C
	for <lists+linux-can@lfdr.de>; Wed, 17 Sep 2025 14:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7AE2E174B;
	Wed, 17 Sep 2025 14:15:24 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from b2682.mx.srv.dfn.de (b2682.mx.srv.dfn.de [194.95.235.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF662E2280
	for <linux-can@vger.kernel.org>; Wed, 17 Sep 2025 14:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.95.235.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758118523; cv=none; b=adYb1rVDRM7yXa+yWM3shllk+BgMVkYgNAHn09dHTdGdc632lUNdyskm5cdDd3hSLwVqGXv5urwPeLhcacSYiX8PdBkKFMP/Tt1dE4GXi0UVFhpY2XDacYYo1489k5hyB+qI1Y1RetfOQSi97FI1SJldcWEa/ZlNKIqzvzfOoAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758118523; c=relaxed/simple;
	bh=YM+qKy9z1dZ0soGwIfa61oKzF7ybLZUroEBbcebTeG0=;
	h=MIME-Version:Content-Type:Message-ID:Date:From:To:Cc:Subject:
	 In-Reply-To:References; b=cK0FfdgjPgz55mGzuBHQDlVt4em4HHacd0mKuoEhgAESIwvh39ufngUjbOOljKgGJ0QGYVOIWQKIwF3qBk63Sp7nv5H0/CY2KQySlHG1xsmc4IegBaxXu+9xlpacmiufbAjRfVNvCe8D9O76mcrRbg8iKCK7kJjvIPlpMr1x0xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=elektron.ikp.physik.tu-darmstadt.de; spf=none smtp.mailfrom=elektron.ikp.physik.tu-darmstadt.de; arc=none smtp.client-ip=194.95.235.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=elektron.ikp.physik.tu-darmstadt.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=elektron.ikp.physik.tu-darmstadt.de
Received: from mail-relay152.hrz.tu-darmstadt.de (mail-relay152.hrz.tu-darmstadt.de [IPv6:2001:41b8:83f:1611::152])
	by b2682.mx.srv.dfn.de (Postfix) with ESMTPS id C17C83A00E4;
	Wed, 17 Sep 2025 16:09:17 +0200 (CEST)
Received: from elektron.ikp.physik.tu-darmstadt.de (elektron.ikp.physik.tu-darmstadt.de [130.83.133.205])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail-relay152.hrz.tu-darmstadt.de (Postfix) with ESMTPS id 4cRgcX59yRz43px;
	Wed, 17 Sep 2025 16:09:16 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Message-ID: <26826.49420.90639.340241@gargle.gargle.HOWL>
Date: Wed, 17 Sep 2025 16:09:16 +0200
From: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: =?iso-8859-1?Q?St=E9phane?= Grosjean <stephane.grosjean@hms-networks.com>,
    linux-can Mailing List <linux-can@vger.kernel.org>
Subject: Re: PCAN-USB FD: shift-out-of-bounds
In-Reply-To: <20250917-aboriginal-refined-honeybee-82b1aa-mkl@pengutronix.de>
References: <20250917-aboriginal-refined-honeybee-82b1aa-mkl@pengutronix.de>
X-Header-TUDa: <1f8V8P6bx1EpgtuL0ze2xKFjTZLOinet6n4odBaVAT48L0t3hhbP2cRDkiolBcIi3hJ6lewgvyne945q5Npbxnjw9LlIEdJm1.1758118157>
X-TUDa-Umlauf: 1

Hello,

probably pcan=5Fusb=5Fcore.c:114 should read:

delta=5Fts &=3D (1ULL << time=5Fref->adapter->ts=5Fused=5Fbits) - 1;

Cheers
>>>>> "Marc" =3D=3D Marc Kleine-Budde <mkl@pengutronix.de> writes:

    Marc> Hello St=E9phane, with the recent Debian kernel
    Marc> (6.16.7+deb14-amd64), the undefined behavior sanitizer
    Marc> triggered with my "0c72:0012 PEAK System PCAN-USB FD":

    Marc> | ------------[ cut here ]------------ | UBSAN:
    Marc> shift-out-of-bounds in
    Marc> /build/reproducible-path/linux-6.16.7/drivers/net/can/usb/pea=
k=5Fusb/pcan=5Fusb=5Fcore.c:114:19

--=20
Uwe Bonnes                bon@elektron.ikp.physik.tu-darmstadt.de

Institut fuer Kernphysik  Schlossgartenstrasse 9  64289 Darmstadt
--------- Tel. 06151 1623569 ------- Fax. 06151 1623305 ---------

