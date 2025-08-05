Return-Path: <linux-can+bounces-4192-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B41B1D494
	for <lists+linux-can@lfdr.de>; Thu,  7 Aug 2025 11:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13931724EF7
	for <lists+linux-can@lfdr.de>; Thu,  7 Aug 2025 09:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA531F0E34;
	Thu,  7 Aug 2025 09:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=capitalcraft.pl header.i=@capitalcraft.pl header.b="CmOVbv97"
X-Original-To: linux-can@vger.kernel.org
Received: from mail.capitalcraft.pl (mail.capitalcraft.pl [57.129.67.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C652A1CF
	for <linux-can@vger.kernel.org>; Thu,  7 Aug 2025 09:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.67.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754557889; cv=none; b=SjKCz4VSSLMMt/s1KukzXmiVawGUJla+/VXMNauwnrQDG/hzgpv9UhoGe722mOs1SzcOld8ETRe1BhCObmrFbcAl2A1ctNUlGThRv0gMid/8n9X/8wmvo+fk2y9e0nH9Gt7cARRdBhS1Uv+vJBB7Pd1sG9GM0c8zLROvFBwBe5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754557889; c=relaxed/simple;
	bh=4udjhVtkPvpeQ4By44W9lTmmyaXV2fwWY0xc+9IIdSA=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=IKZBBC/Lg3eyL9IPtCWuRc1HMMwQzNhIILGE55KztL/dTwpTkSrNIh+96F4SAWRVmExYDIxStKZY89x4vMm7JcrY9cyOCvtsuU9y1sX5Sj14IJBzrLyc988/ci5S1tNfh8+yBg5wnz+0XVP+G6h+hYo9SsmmSAfUlssbB3Lj10k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=capitalcraft.pl; spf=pass smtp.mailfrom=capitalcraft.pl; dkim=pass (2048-bit key) header.d=capitalcraft.pl header.i=@capitalcraft.pl header.b=CmOVbv97; arc=none smtp.client-ip=57.129.67.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=capitalcraft.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=capitalcraft.pl
Received: by mail.capitalcraft.pl (Postfix, from userid 1002)
	id 4024A26BCC; Tue,  5 Aug 2025 07:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=capitalcraft.pl;
	s=mail; t=1754379720;
	bh=4udjhVtkPvpeQ4By44W9lTmmyaXV2fwWY0xc+9IIdSA=;
	h=Date:From:To:Subject:From;
	b=CmOVbv97azJhsc3bYAQ7iSxnM2i5rZpN82dWZEv/Ju+v2trzX9+UKwB9dLqf+KKzz
	 qVbZ0q9DDqlT583QuQepBgW2UmIFzxbqfxws+qGF8N+rINPeufQxvBp2W3O9+6wu6S
	 Hv65ADJnVvpPgmsWkVX6hW3dA89aC4YUVuNaafGrHwOpIBQcG5aDe8jf9r8h0wvKPQ
	 9lgLf8E+nSWOTyJQQT/yUib7JhvqUhELMaUQM2VcCcycM81EqC3JbXDCyb/l291XJP
	 CFNCStpRpznoIJBvM7yb74cDCr5ucSc6hZ57Ydy4pdAEqzovl0Ah/1X9gPcSpbwxJo
	 pHtuRGpRYOtVg==
Received: by mail.capitalcraft.pl for <linux-can@vger.kernel.org>; Tue,  5 Aug 2025 07:40:40 GMT
Message-ID: <20250805064500-0.1.3u.s6i2.0.h4n1sbapnp@capitalcraft.pl>
Date: Tue,  5 Aug 2025 07:40:40 GMT
From: "Karolina Dylkiewicz" <karolina.dylkiewicz@capitalcraft.pl>
To: <linux-can@vger.kernel.org>
Subject: Prawo pracy - zmiany 
X-Mailer: mail.capitalcraft.pl
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Szanowni Pa=C5=84stwo,

obs=C5=82uga prawna w zakresie prawa pracy to nie tylko dba=C5=82o=C5=9B=C4=
=87 o dokumenty i zgodno=C5=9B=C4=87 z przepisami. To przede wszystkim re=
alne wsparcie w codziennym funkcjonowaniu firmy i bezpiecze=C5=84stwo org=
anizacyjne.

W ramach wsp=C3=B3=C5=82pracy oferujemy m.in.:
=E2=80=A2 przygotowywanie i negocjowanie um=C3=B3w oraz kontrakt=C3=B3w,
=E2=80=A2 wsparcie przy zatrudnianiu i legalizacji pracy cudzoziemc=C3=B3=
w,
=E2=80=A2 doradztwo w procesach restrukturyzacyjnych,
=E2=80=A2 przeprowadzanie audyt=C3=B3w prawno-pracowniczych (due diligenc=
e),
=E2=80=A2 reprezentacj=C4=99 w sporach z ZUS oraz pracownikami.

Dzi=C4=99ki wieloletniemu do=C5=9Bwiadczeniu w obs=C5=82udze firm z podob=
nej bran=C5=BCy rozumiemy Pa=C5=84stwa potrzeby i proponujemy rozwi=C4=85=
zania dopasowane do rzeczywistych wyzwa=C5=84 biznesowych.

Z przyjemno=C5=9Bci=C4=85 przedstawi=C4=99 szczeg=C3=B3=C5=82y =E2=80=93 =
czy znajd=C4=85 Pa=C5=84stwo chwil=C4=99 na rozmow=C4=99 lub spotkanie?


Pozdrawiam
Karolina Dylkiewicz

