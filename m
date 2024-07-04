Return-Path: <linux-can+bounces-949-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D33E927C78
	for <lists+linux-can@lfdr.de>; Thu,  4 Jul 2024 19:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 478912816F0
	for <lists+linux-can@lfdr.de>; Thu,  4 Jul 2024 17:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2943D73454;
	Thu,  4 Jul 2024 17:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=st.oth-regensburg.de header.i=@st.oth-regensburg.de header.b="J7cl4x4p"
X-Original-To: linux-can@vger.kernel.org
Received: from a2752.mx.srv.dfn.de (a2752.mx.srv.dfn.de [194.95.233.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2647344D
	for <linux-can@vger.kernel.org>; Thu,  4 Jul 2024 17:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.95.233.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720115227; cv=none; b=AfHXNfIRtnoufOmkmD1qGB6nUpvPH1srlFVKySxO/WtCyXSAcOWdUsQtotj9ZyvpVae5UIqJkeh8vD7WttAyaBY2Uhf8VKVWVDpbGaErREKEIy7MMidqjIM2Id2/IUZIi60rNMK26cxWhr9RLkLdfIm6iNl5C1f5kSmwWVOlW88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720115227; c=relaxed/simple;
	bh=fyx7IuXZFTjdYY99H6cagOuDhxtZOQ+DXKXRRwNGHpw=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JV9K3tWitE747HKYFpbJ2v6m/VBrU14WUyRmlT6vNw5aB/BJoi2vm84ZYvpHtRnoL9qetIAa9XSHCUdsOntpgnRbIgTokAa3yfbO5/vrzWdtttK+KtSw86RocOBK6t6I+OoZZFweZG1X06uyoRTl+6rzv1Jqybg2Tghw3QxKdBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=st.oth-regensburg.de; spf=pass smtp.mailfrom=st.oth-regensburg.de; dkim=pass (2048-bit key) header.d=st.oth-regensburg.de header.i=@st.oth-regensburg.de header.b=J7cl4x4p; arc=none smtp.client-ip=194.95.233.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=st.oth-regensburg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=st.oth-regensburg.de
Received: from mta01.hs-regensburg.de (mta01.hs-regensburg.de [IPv6:2001:638:a01:1096::11])
	by a2752.mx.srv.dfn.de (Postfix) with ESMTPS id 013082E0180;
	Thu,  4 Jul 2024 19:40:45 +0200 (CEST)
Received: from E16S03.hs-regensburg.de (e16s03.hs-regensburg.de [IPv6:2001:638:a01:8013::93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client CN "E16S03", Issuer "E16S03" (not verified))
	by mta01.hs-regensburg.de (Postfix) with ESMTPS id 4WFP7d3YX5zxq4;
	Thu,  4 Jul 2024 19:40:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=st.oth-regensburg.de; s=mta01-20211122; t=1720114845;
	bh=fyx7IuXZFTjdYY99H6cagOuDhxtZOQ+DXKXRRwNGHpw=;
	h=From:To:CC:Subject:Date:From;
	b=J7cl4x4peZ41H1nVwjTr4PxmRdSlSaEIN2sR/9uqGV2pFyo/p+Rk3sG2nD5pc9Hoi
	 qdCKm58dU7W/gw/X9nLtNpSaYJaqDGllFu8YdQregvrslNjEgP/zPKMeViqAZfNjUX
	 MU2VDHCJzh4dSorVsevJLOLjXlcGRRxKkD6G+6iBB8d1o974YqsUxxfPtfJghx8jvG
	 7CFSggUmGBq/RHpj0qErqE0WGXAHfBpK+Z4VAkWUFwRnAf25bw/8uEc+4VVU+0822y
	 9+apKlNjzk3nJIEzZmDl3RcllHGw6ZgY2Jzhf7rpI3sSd8nTgpGKlGmkZqVru6TgEK
	 DVli9nHGLjghg==
Received: from E16S03.hs-regensburg.de (2001:638:a01:8013::93) by
 E16S03.hs-regensburg.de (2001:638:a01:8013::93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 4 Jul 2024 19:40:45 +0200
Received: from E16S03.hs-regensburg.de ([fe80::11ce:e71b:def6:d334]) by
 E16S03.hs-regensburg.de ([fe80::11ce:e71b:def6:d334%4]) with mapi id
 15.01.2507.039; Thu, 4 Jul 2024 19:40:45 +0200
From: Matthias Unterrainer <matthias.unterrainer@st.oth-regensburg.de>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>, Wolfgang Mauerer
	<wolfgang.mauerer@oth-regensburg.de>, "nils.weiss@dissecto.com"
	<nils.weiss@dissecto.com>
Subject: Introducing new Kernel Module for CAN over IP Networks
Thread-Topic: Introducing new Kernel Module for CAN over IP Networks
Thread-Index: AQHazjkcCYlBunQofUOEunI5kJWZzw==
Date: Thu, 4 Jul 2024 17:40:45 +0000
Message-ID: <77a04054acea40a886d371adbd8d25d1@st.oth-regensburg.de>
Accept-Language: de-DE, en-GB, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Linux-CAN Community,

my name is Matthias and I recently developed a kernel module during my Bach=
elor's thesis that allows for transferring CAN frames over IP networks, sim=
ilar to userland tools like socketcand [0] or cannelloni [1].

I wrote the thesis at dissecto GmbH [2], a german Startup that specializes =
in security diagnostics and analytics for embedded systems, primarily withi=
n the automotive industry.

The idea behind the project is that dissecto has developed a hardware devic=
e that can be connected to a CAN bus and acts as an ethernet gateway to the=
 bus. It is capable of capturing the CAN traffic along with the correspondi=
ng timestamps and send this data via UDP or it can receive CAN frames via U=
DP as well and pass them on to the CAN bus.
This allows for remote interaction with a CAN bus, as well as an accurate a=
nalyses of CAN traffic, as packets contain precise time stamps.

An architectural design decision was to develop it as kernel module because=
 of lower latencies and high throughput.
For example, my measurements show that the average time it takes a CAN fram=
e to get processed by the module is just about 1/4 of the time it takes app=
lications like socketcand or cannelloni.

We have published the module on GitHub [3], and would appreciate your feedb=
ack and thoughts.

If anyone is interested in this functionality for the same or similar use c=
ases, please don't hesitate to contact us.

Best regards
Matthias Unterrainer


[0] https://github.com/linux-can/socketcand
[1] https://github.com/mguentner/cannelloni
[2] https://dissec.to
[3] https://github.com/dissecto-GmbH/can2eth-kernel-module=

