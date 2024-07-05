Return-Path: <linux-can+bounces-951-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A91529287A4
	for <lists+linux-can@lfdr.de>; Fri,  5 Jul 2024 13:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9FC1B2103C
	for <lists+linux-can@lfdr.de>; Fri,  5 Jul 2024 11:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DB11487FE;
	Fri,  5 Jul 2024 11:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=st.oth-regensburg.de header.i=@st.oth-regensburg.de header.b="N08okFvC"
X-Original-To: linux-can@vger.kernel.org
Received: from b2752.mx.srv.dfn.de (b2752.mx.srv.dfn.de [194.95.235.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD6B1459EA
	for <linux-can@vger.kernel.org>; Fri,  5 Jul 2024 11:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.95.235.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720178255; cv=none; b=hqLKP5l709jdlv80lryrrSpNw+zXONx6Nj0c3ikYf2Ebs/TyiubgdcVeiYN7kBfM95wNxb3D/ETkEQ3Dcpv318dZPCL9zKnoYpEE6Wg5YIjDN88/kICaRpW9SStpz7PG/dNfBZmYOLAVnw3flL9PlGLZEODlHMOgR3t3XTX0TJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720178255; c=relaxed/simple;
	bh=aT6OJlbzmOnEW74sT6AFIb5zVbUTs+m4taphSbliX5s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GJq15FBg3rLJBz0b/TOm05wtMz6ygG01GWZcreZMOwOUm6FQLwlfs/6B3PIWI5hJhe9uDsOoS5zv5gs3mVDO9y/iUg/MdyL3wzGUF2eKYyvPJautpTTyftXB2FtdJbpxHy5dgactpFSS3GLeMBX9hhKcy+Bgh5J0UsqLL5lKfCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=st.oth-regensburg.de; spf=pass smtp.mailfrom=st.oth-regensburg.de; dkim=pass (2048-bit key) header.d=st.oth-regensburg.de header.i=@st.oth-regensburg.de header.b=N08okFvC; arc=none smtp.client-ip=194.95.235.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=st.oth-regensburg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=st.oth-regensburg.de
Received: from mta02.hs-regensburg.de (mta02.hs-regensburg.de [194.95.104.12])
	by b2752.mx.srv.dfn.de (Postfix) with ESMTPS id 98B313E010B;
	Fri,  5 Jul 2024 13:17:22 +0200 (CEST)
Received: from E16S03.hs-regensburg.de (e16s03.hs-regensburg.de [IPv6:2001:638:a01:8013::93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client CN "E16S03", Issuer "E16S03" (not verified))
	by mta02.hs-regensburg.de (Postfix) with ESMTPS id 4WFrZp1Bf4zxw5;
	Fri,  5 Jul 2024 13:17:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=st.oth-regensburg.de; s=mta02-20211122; t=1720178242;
	bh=aT6OJlbzmOnEW74sT6AFIb5zVbUTs+m4taphSbliX5s=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=N08okFvCFhR9i6zE1ept3cH0XxtAQtodEKrDBJW9I0cRLMW3uH0V3J8+fepkXzE3n
	 E+E16ocJHnIp581eWjAflmAByCy5ECyUzf3t9uA/c1YiaeWy1E+Pxkcpg8BqHHC1qK
	 cBU2+iIMxOe+GRsR6N09ek71pP+Nnk+EWdPeg9BZF+U1HJsZwZSjddLKNEjnyOFlW1
	 aDJSG/TXntDdKwJ8doClhPrxKJ0pGPVcp3q4iCOkeNRgii1asDAoo71O01LbJst7d8
	 wqaW9Aug37gKDoei8Vfq2kbnwX0Ee560SraHPVD2IYdJHm6PLmu2gQFccoKBa/7VuT
	 0QAVy5m/Xu0sg==
Received: from E16S03.hs-regensburg.de (2001:638:a01:8013::93) by
 E16S03.hs-regensburg.de (2001:638:a01:8013::93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 5 Jul 2024 13:17:21 +0200
Received: from E16S03.hs-regensburg.de ([fe80::11ce:e71b:def6:d334]) by
 E16S03.hs-regensburg.de ([fe80::11ce:e71b:def6:d334%4]) with mapi id
 15.01.2507.039; Fri, 5 Jul 2024 13:17:21 +0200
From: Matthias Unterrainer <matthias.unterrainer@st.oth-regensburg.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>
CC: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>, Wolfgang Mauerer
	<wolfgang.mauerer@oth-regensburg.de>, "nils.weiss@dissecto.com"
	<nils.weiss@dissecto.com>
Subject: AW: [EXT] Re: Introducing new Kernel Module for CAN over IP Networks
Thread-Topic: [EXT] Re: Introducing new Kernel Module for CAN over IP Networks
Thread-Index: AQHazjkcCYlBunQofUOEunI5kJWZz7Hm2CeAgAEh1Z0=
Date: Fri, 5 Jul 2024 11:17:21 +0000
Message-ID: <779aad5a9418411c901ee86500692c71@st.oth-regensburg.de>
References: <77a04054acea40a886d371adbd8d25d1@st.oth-regensburg.de>,<32535446-91d8-47ca-b7a3-556f91ec85e9@hartkopp.net>
In-Reply-To: <32535446-91d8-47ca-b7a3-556f91ec85e9@hartkopp.net>
Accept-Language: de-DE, en-GB, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Oliver,

as you have asked, I have now added documentation to the module.
If something is still missing, just tell me and I will try to fix it.

Best regards,
Matthias Unterrainer
________________________________________
Von: Oliver Hartkopp <socketcan@hartkopp.net>
Gesendet: Donnerstag, 4. Juli 2024 21:47:55
An: Matthias Unterrainer; linux-can@vger.kernel.org
Cc: Ralf Ramsauer; Wolfgang Mauerer; nils.weiss@dissecto.com
Betreff: [EXT] Re: Introducing new Kernel Module for CAN over IP Networks

Hi Matthias,

can you please add some documentation to the GitHub's README.md file, e.g.

- what is the plan (mainly your description below)
- how to build and load the module
- how to configure the IP/Port with 1 or 2 examples
- e.g. example how to create a CAN-over-UDP bridge between two IP hosts
- protocol description how the CAN frames are embedded into UDP/IP

It is hard to get all these necessary information which is needed to get
behind your idea from the code.

Thanks and best regards,
Oliver

On 04.07.24 19:40, Matthias Unterrainer wrote:
> Hi Linux-CAN Community,
>
> my name is Matthias and I recently developed a kernel module during my Ba=
chelor's thesis that allows for transferring CAN frames over IP networks, s=
imilar to userland tools like socketcand [0] or cannelloni [1].
>
> I wrote the thesis at dissecto GmbH [2], a german Startup that specialize=
s in security diagnostics and analytics for embedded systems, primarily wit=
hin the automotive industry.
>
> The idea behind the project is that dissecto has developed a hardware dev=
ice that can be connected to a CAN bus and acts as an ethernet gateway to t=
he bus. It is capable of capturing the CAN traffic along with the correspon=
ding timestamps and send this data via UDP or it can receive CAN frames via=
 UDP as well and pass them on to the CAN bus.
> This allows for remote interaction with a CAN bus, as well as an accurate=
 analyses of CAN traffic, as packets contain precise time stamps.
>
> An architectural design decision was to develop it as kernel module becau=
se of lower latencies and high throughput.
> For example, my measurements show that the average time it takes a CAN fr=
ame to get processed by the module is just about 1/4 of the time it takes a=
pplications like socketcand or cannelloni.
>
> We have published the module on GitHub [3], and would appreciate your fee=
dback and thoughts.
>
> If anyone is interested in this functionality for the same or similar use=
 cases, please don't hesitate to contact us.
>
> Best regards
> Matthias Unterrainer
>
>
> [0] https://github.com/linux-can/socketcand
> [1] https://github.com/mguentner/cannelloni
> [2] https://dissec.to
> [3] https://github.com/dissecto-GmbH/can2eth-kernel-module

