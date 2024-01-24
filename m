Return-Path: <linux-can+bounces-161-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F8683ACC3
	for <lists+linux-can@lfdr.de>; Wed, 24 Jan 2024 16:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A80D81C239B0
	for <lists+linux-can@lfdr.de>; Wed, 24 Jan 2024 15:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDC315BE;
	Wed, 24 Jan 2024 15:06:33 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from projects.drlauer-research.com (projects.drlauer-research.com [88.99.0.140])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800781AAAE
	for <linux-can@vger.kernel.org>; Wed, 24 Jan 2024 15:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.0.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706108793; cv=none; b=i4zNRsO/tsRQwq3rRlBXLsruY2dlP2IWda4AhZ9p7q7M95sf172ScZktCbbs26d+L/JWYZPVPx3YILeg1pfb3D9cuddHnrrG3HxDp10EjYdW+vxgpulCwZIOL45XDTve2onyL5DckQJs4h+KCFnhLPAraWsBad5xJgA8DhO0Tag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706108793; c=relaxed/simple;
	bh=haAiBR02pxDuZtPb/aXUGaxM1Vsu7BABpZ9tFNcTu7Y=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=ElPjjsBiDS2/5bXXe4e0/XTMM9TT2iikYvndQX3pCaCGhLM6Uvn5/YA1nT1GE42G3eK1stlz3uuUNn25BBhLgM+YRVd0u8lcGCvF4QnirWZP7Q8NawxdGjNYhKw6NhvVKKfcgejl11SM/C0N/HD7mnC9vjiBqT0N1HLjxTF+I7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vanille.de; spf=pass smtp.mailfrom=vanille.de; arc=none smtp.client-ip=88.99.0.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vanille.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vanille.de
Received: from smtpclient.apple (ip-109-090-164-198.um36.pools.vodafone-ip.de [109.90.164.198])
	by projects.drlauer-research.com (Postfix) with ESMTPSA id CB908480198
	for <linux-can@vger.kernel.org>; Wed, 24 Jan 2024 15:59:07 +0100 (CET)
From: "Dr. Michael 'Mickey' Lauer" <mickey@vanille.de>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Candump timing issues
Message-Id: <AE1EC1F4-8356-49AA-8CB2-748683014B23@vanille.de>
Date: Wed, 24 Jan 2024 15:58:57 +0100
To: linux-can@vger.kernel.org
X-Mailer: Apple Mail (2.3774.400.31)

I=E2=80=99m writing a MCP2518fd driver (for an ESP32) and am using my =
Logic Analyzer
to measure timing. I have a simple =E2=80=9Eecho=E2=80=9C program where =
the MCP repeats every
CAN frame it receives. The sender is a pretty fast Linux machine using

cangen can0 -I 777 -L 8 -D r -v -v -g 1000

I=E2=80=99m also monitoring this (on the same machine) via

candump -D -catd can0

Here=E2=80=99s an excerpt from a few seconds:

 (000.000000)  can0  777   [8]  94 F8 BF 7E F1 6E 68 6B   '...~.nhk'
 (000.000770)  can0  777   [8]  94 F8 BF 7E F1 6E 68 6B   '...~.nhk'
 (000.999518)  can0  777   [8]  0E 99 51 48 E6 FF CE 64   '..QH...d'
 (000.000733)  can0  777   [8]  0E 99 51 48 E6 FF CE 64   '..QH...d'
 (000.999406)  can0  777   [8]  AC 1C A4 01 B7 10 FC 7C   '.......|'
 (000.000854)  can0  777   [8]  AC 1C A4 01 B7 10 FC 7C   '.......|'
 (000.999348)  can0  777   [8]  53 DA B4 5B 58 EA B4 5C   'S..[X..\'
 (000.000769)  can0  777   [8]  53 DA B4 5B 58 EA B4 5C   'S..[X..\'
 (000.999483)  can0  777   [8]  BF 2E 36 77 49 52 A0 1D   '..6wIR..'
 (000.000796)  can0  777   [8]  BF 2E 36 77 49 52 A0 1D   '..6wIR..'
 (000.999389)  can0  777   [8]  16 EF B7 22 85 F0 83 12   '..."....'
 (000.000735)  can0  777   [8]  16 EF B7 22 85 F0 83 12   '..."....'
 (000.999357)  can0  777   [8]  BA C4 BF 45 E3 7C CD 73   '...E.|.s'
 (000.000845)  can0  777   [8]  BA C4 BF 45 E3 7C CD 73   '...E.|.s'
 (000.999404)  can0  777   [8]  95 1B 65 1C 81 15 DB 64   '..e....d'
 (000.000731)  can0  777   [8]  95 1B 65 1C 81 15 DB 64   '..e....d=E2=80=98=


Now I really wonder about these values, in particular the
time between the =E2=80=9Equestion=E2=80=9C and the =E2=80=9Eanswer=E2=80=9C=
. This is a CAN 2.0B
bus @ 500000bps with only two nodes.

Looking at my Logic Analyzer, it takes me about
160=C2=B5s to send the received frame back into the MCP,
where then the arbitration starts on the CAN bus.

It takes an additional 200=C2=B5s for the frame to be sent on the bus,
so I=E2=80=99d expect to see a maximum of 360=C2=B5s, if this is using =
hardware
timestamps.

I could only see 750=C2=B5s, if I were to measure from the beginning of
the =E2=80=9Equestion=E2=80=9C and the end of the =E2=80=9Eanswer=E2=80=9C=
 frame, but that=E2=80=99s make
sense.

Is my understanding of these timestamps wrong?

Cheers,

:M:


