Return-Path: <linux-can+bounces-4015-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E2CB0BDC2
	for <lists+linux-can@lfdr.de>; Mon, 21 Jul 2025 09:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B39A188496D
	for <lists+linux-can@lfdr.de>; Mon, 21 Jul 2025 07:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34234190072;
	Mon, 21 Jul 2025 07:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=growora.pl header.i=@growora.pl header.b="wZPIwRE4"
X-Original-To: linux-can@vger.kernel.org
Received: from mail.growora.pl (mail.growora.pl [51.254.119.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0650126BF7
	for <linux-can@vger.kernel.org>; Mon, 21 Jul 2025 07:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.254.119.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753083367; cv=none; b=YcI1Y5yPBpdziDRT4I+9a2nM+8C9eEbe5KLNXJx5b5AMcx9Yc/amDz2fOjuF6KyGSgDr393lVsHXMLLWMOpV+Ypg1o9sON2wzYjU1gpWV1o8MWlto+Xly+SAdXA8Gd1FBs/U8ra3Kkkp1JK6H9mOqo84FrTp60sWriyxFBMlgvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753083367; c=relaxed/simple;
	bh=RSy3akR1+Z0TK1MqUcCTAhuNDshd4oA9g7Cu4aFIABY=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=EZvHSmgthNwcSG+tIGHKbzPrOJAvMW5Fq+SO4Y1EVoIbWUxNDlD9Zwu9XMgbmk5clbWlXseTg8ByajEcoS5669oiAfQQP80IgBodtYKpO3Epvy/8/yj0tHISeSL2QfmlYWMVP3o98xJn0eFibuTM1wVMg7euDfYblIPd6WRVyYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=growora.pl; spf=pass smtp.mailfrom=growora.pl; dkim=pass (2048-bit key) header.d=growora.pl header.i=@growora.pl header.b=wZPIwRE4; arc=none smtp.client-ip=51.254.119.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=growora.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=growora.pl
Received: by mail.growora.pl (Postfix, from userid 1002)
	id C7D702270C; Mon, 21 Jul 2025 09:35:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=growora.pl; s=mail;
	t=1753083361; bh=RSy3akR1+Z0TK1MqUcCTAhuNDshd4oA9g7Cu4aFIABY=;
	h=Date:From:To:Subject:From;
	b=wZPIwRE4eMy7PJNkS/KWjxopmt8x36U5h4Y/vjHz3YB7p4808tSLxm8tvomBW/v7/
	 rnuOvjF9yP5v81pkslSChcJlISMhwz7pVBPl+8DNySZd33ftX0G+Co2Z7KxUgGWbBx
	 HrcyvcsbZ1dTl1L35kpnS6rBlJS2nLMKcDZ1AuwL3gm1+qmgFO9HK+oEGycYbJLeGB
	 CSUmoAWnrUjsf5v8iGSfqGZPkXBUX5Io6IV77cEFTRa4LOVGM8FykiyzfNXWaDssVR
	 llwqBJ1pGjM8hgF5I7ktJzvHySasIi9n4ljEXFinkOmTgXJp4IOxjDWWN5fdZLHBeC
	 3iL18biO17o2g==
Received: by mail.growora.pl for <linux-can@vger.kernel.org>; Mon, 21 Jul 2025 07:35:59 GMT
Message-ID: <20250721084500-0.1.kq.29pt5.0.9g8gl814mg@growora.pl>
Date: Mon, 21 Jul 2025 07:35:59 GMT
From: "Mateusz Hopczak" <mateusz.hopczak@growora.pl>
To: <linux-can@vger.kernel.org>
Subject: Wsparcie programistyczne - termin spotkania 
X-Mailer: mail.growora.pl
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Szanowni Pa=C5=84stwo,

czy w Pa=C5=84stwa firmie rozwa=C5=BCaj=C4=85 Pa=C5=84stwo rozw=C3=B3j no=
wego oprogramowania lub potrzebuj=C4=85 zaufanego zespo=C5=82u, kt=C3=B3r=
y przejmie odpowiedzialno=C5=9B=C4=87 za stron=C4=99 technologiczn=C4=85 =
projektu?

Jeste=C5=9Bmy butikowym software housem z 20-osobowym zespo=C5=82em in=C5=
=BCynier=C3=B3w. Specjalizujemy si=C4=99 w projektach high-tech i deeptec=
h =E2=80=93 od zaawansowanych system=C3=B3w AI/ML, przez blockchain i IoT=
, a=C5=BC po aplikacje mobilne, webowe i symulacyjne (m.in. Unreal Engine=
).

Wspieramy firmy technologiczne oraz startupy na r=C3=B3=C5=BCnych etapach=
: od koncepcji, przez development, po skalowanie i optymalizacj=C4=99. Dz=
ia=C5=82amy elastycznie =E2=80=93 jako partnerzy, podwykonawcy lub ventur=
e builderzy.

Je=C5=9Bli szukaj=C4=85 Pa=C5=84stwo zespo=C5=82u, kt=C3=B3ry rozumie z=C5=
=82o=C5=BCono=C5=9B=C4=87 projekt=C3=B3w i wnosi realn=C4=85 warto=C5=9B=C4=
=87 technologiczn=C4=85 =E2=80=93 ch=C4=99tnie porozmawiamy.

Czy mogliby=C5=9Bmy um=C3=B3wi=C4=87 si=C4=99 na kr=C3=B3tk=C4=85 rozmow=C4=
=99, by sprawdzi=C4=87 potencja=C5=82 wsp=C3=B3=C5=82pracy?


Z pozdrowieniami
Mateusz Hopczak

