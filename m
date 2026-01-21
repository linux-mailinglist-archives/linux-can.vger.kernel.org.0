Return-Path: <linux-can+bounces-6240-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNOgBSGfcGlyYgAAu9opvQ
	(envelope-from <linux-can+bounces-6240-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 21 Jan 2026 10:40:49 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B126954914
	for <lists+linux-can@lfdr.de>; Wed, 21 Jan 2026 10:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC78D865864
	for <lists+linux-can@lfdr.de>; Wed, 21 Jan 2026 09:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B48347D937;
	Wed, 21 Jan 2026 09:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="b7R49c8U";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="b7R49c8U"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020102.outbound.protection.outlook.com [52.101.84.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DE247CC7C;
	Wed, 21 Jan 2026 09:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.102
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768987273; cv=fail; b=e3csPqOEWxGy3TUhU7G4iD6obzAywyjOGESG//ic/PRE2wKXR1m++9FrGQVCmvZF4Qoz1c8fs3o6dgfaJ5pHwZVFm0B3+mBHhcvOZEUr1DmOSfAXvO1mQ9f13mIW5GN+TMcjUIAWzrsQ4njdu2XU+Qa1+cfS6RFn3xtnn0nXChQ=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768987273; c=relaxed/simple;
	bh=IuPheYGH+lSPEb9HuW+RyIfNZwsN3DuPIhGk7kYkEkM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=uzlXfITUnwLJfCj0wP22gFA/L8kutB1IvmwE79VNbPw9g9Aw3C/m+Yytv5c8phfMCfbaR/75BiXfxQiuGmiruS9qm+82WFuYFhNHcLrNDDI2xjkLS6RNFAvPsljW3iw4V00mxI2L1uM+WPdMjQ7Rt4wVETF8M93wyl95/vJZP0k=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=b7R49c8U; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=b7R49c8U; arc=fail smtp.client-ip=52.101.84.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=C8gKtiQnvnOBa+P21sVVsmkUcxLCnuJtHAp0zQYCSHs+iPK0nEYke3Wz6atguUwNyHm17XhGK3TabY8KS7JLROJcCmb5jChvhTdK1PWoLlmWAVEXxwvFbuRujjsvpjjuR7jvUMDw+DoFJph870jMLSD+MB8gfzQqN1I3Qhu6G4fp54LxjDR1b8R27LFKy4nzHKKbntlhD671xtxSfwqXK/F3rc48b09w1bM7J0iZsUpLfYYCVwi68kaeWq6VBhsdvH+KSVpswBBfyWZuTY2ZcJiXS4ytt1ZaoZlSWS26n7YKjp7DK6vDB4Rb00aRPZt8ydM6PNeuG07Sm95t+Q6rKQ==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjzZNAGaUt2CgGZ3DbY4ILyKnzQXxS+kftXIto706Cc=;
 b=Mbi0WZYvipW8nRbvwZo7CegMn7oCFqbJuB7wPtgcSmplccOoPkV0ubEfmMvTDAtSxJe6WKTYxPGyUS1BhRs86ZBPxAsKQD5jVvc4XOn/DUPuVgcYzSFDMqvAjRage76HAIg84AOoRP1ntyDjbjyoCM+V1DPKauS0kCV33NELyUXgSQs7m6tJZoknzmjNn6RDX0YZRnllr9CH4nX5TAKLciy4uOgir1E1pT9nC80g9KI8sHflwojKznZ7YwaSoHJ+Ep2T4fx+iX8McvMIojvXj7TVRwMVXQU/rTj+4nQzdraMlzQzlJDUnLCjfzLg1EeaWeKTU9irGr3mf96Pah8baA==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjzZNAGaUt2CgGZ3DbY4ILyKnzQXxS+kftXIto706Cc=;
 b=b7R49c8Ubo1oafShJCrgIC/Hz8vZkd4kJ7Hi0x7NVmWOgmBDm+ZoIkzL+ox6LGLukaOi9CRd3UnhKXBENYu3i5qtJ/nteJuWJFK5j8qgOqHmno7Ocp3bX9EaxRGuTSSwLhUkPmhip7yA0ImUeY/KkyiBnDZ9gA0WV2jvEaBzptw=
Received: from DU6P191CA0039.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::13)
 by GV2PR04MB11825.eurprd04.prod.outlook.com (2603:10a6:150:2cf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.9; Wed, 21 Jan
 2026 09:21:05 +0000
Received: from DB1PEPF000509F1.eurprd03.prod.outlook.com
 (2603:10a6:10:53f:cafe::7) by DU6P191CA0039.outlook.office365.com
 (2603:10a6:10:53f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 09:21:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB1PEPF000509F1.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1
 via Frontend Transport; Wed, 21 Jan 2026 09:21:05 +0000
Received: from emails-4708717-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-21.eu-west-1.compute.internal [10.20.5.21])
	by mta-outgoing-dlp-141-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 83E3A805CB;
	Wed, 21 Jan 2026 09:21:05 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1768987265; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=tjzZNAGaUt2CgGZ3DbY4ILyKnzQXxS+kftXIto706Cc=;
 b=gTaHomXP2RGIKLN1UH2qETJfYWMhB6riGZ/Kdh0dbt4b9cT4UlxrhrPuUDApec6OoNp0b
 21J8gjjqY8ntWdk8BPzEb2wZ/unhGouRkWUgmevkrEbvu6BG225qnJ192DbH+4/aXDQdwD5
 dIT0DEkJR/V7A1DbZHtd9yaEZGOH8NY=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1768987265;
 b=IrINqvta5jNIbR2gNHerj4nQO5npDVkiq5i77jqfjl+oRJF/84D6bzBtC7x0btOYo0xcU
 Hj2nvspK3FBznx/byfTuY/Xl09VNkfL2Nle0eRmjRBmuY8+nYGAgvdjPc5c9/b5DL9QWUiS
 bQvflHsavQuDQYiNe0JXGO4Y9MH3ZWg=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WT7P47UMrrQZhir6dJ2p2B+v3pUn9GBbcpLtDutonY1QZ4vmSCUZ5gcw6ZYC0YmOCFzqxPW4kC3Kr7nTSe4IY9LCGEc5SuMJlf3xSTn+49lkMLKHwot6J5WPPLryiU9MmtcLqeIVvPQjkAqVq834X55Yxr73uJzaOuGo2CS5dhci74BjZQdVKgNOPgfRDJ6PFENEPYKzcZgTeXEAwyVVug/ZydvEQN5TuFeWd8LBlVr3dRxQl9oadXKOPOZNTO/n1cEjpLopkrbd0IKRQ7Z/A5+2ScMbbCM5/TNMQF+7ODrnil+U0Cl1aSlLz+ayWvVRT7M1jzbR1GdGSqUD9YGdXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjzZNAGaUt2CgGZ3DbY4ILyKnzQXxS+kftXIto706Cc=;
 b=ds82yw5ZD0tio30le0r1GLEAxYZy/tC49xpnP57LP+XKxU5N5vDpZ717juKF0ss/vtHHxHneMLcZ+l91RU5XUGZlBcbTZw6DGXWkM0lAp+Hob6acQZNaU/vmVih1/kwf4qdl0GxIUGNNUNGOHpv6WlCF6Ngmgg0ptCKndAf77LmNEUZwZ7nKklz8AErDFAMEwYqpVsWRbuLVDUNCXCVXynzm+K5XjYXilHuwg97Kq8h51DDJ9K8hpd/VP860hZmhvH5+NGZYOGs3LFFwfPUpOym3iuBD3fl1ax8ia0m6lgQ98nkjdzI/5K443JfSUzNApDpHARohkn+LpbSr5fe0tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjzZNAGaUt2CgGZ3DbY4ILyKnzQXxS+kftXIto706Cc=;
 b=b7R49c8Ubo1oafShJCrgIC/Hz8vZkd4kJ7Hi0x7NVmWOgmBDm+ZoIkzL+ox6LGLukaOi9CRd3UnhKXBENYu3i5qtJ/nteJuWJFK5j8qgOqHmno7Ocp3bX9EaxRGuTSSwLhUkPmhip7yA0ImUeY/KkyiBnDZ9gA0WV2jvEaBzptw=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by PR3PR04MB7436.eurprd04.prod.outlook.com (2603:10a6:102:87::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 09:20:58 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%7]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 09:20:58 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Wed, 21 Jan 2026 11:20:40 +0200
Subject: [PATCH v6 3/7] mux: add help text for MULTIPLEXER config option
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-rz-sdio-mux-v6-3-38aa39527928@solid-run.com>
References: <20260121-rz-sdio-mux-v6-0-38aa39527928@solid-run.com>
In-Reply-To: <20260121-rz-sdio-mux-v6-0-38aa39527928@solid-run.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peter Rosin <peda@axentia.se>,
 Aaro Koskinen <aaro.koskinen@iki.fi>,
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>,
 Andi Shyti <andi.shyti@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>,
 Jon Nettleton <jon@solid-run.com>,
 Mikhail Anikin <mikhail.anikin@solid-run.com>, linux-can@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: TLZP290CA0006.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::16) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|PR3PR04MB7436:EE_|DB1PEPF000509F1:EE_|GV2PR04MB11825:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a8eb82d-7471-4667-f321-08de58ce6784
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?dHZScDF1WHFuS0JnTTRCYjVBZFhqSTdlbGhDNTZBQlZGa3NWQXVMSlVSU3M1?=
 =?utf-8?B?bk5OdE9nNTZmeUM5dzN4Z0lPSTRpTzFnWjk2U2U3SmFoRWhpeWs2TkpuaWNG?=
 =?utf-8?B?KzRoSWYzRU5ncUVuNWdMbUFjZzFiQWxUYTJEVmozcXowaUNrd3ZIL2JRaXJm?=
 =?utf-8?B?andiVjVqSzFnMkd2VWVIMWJmSmF0Yy9DZ2l1VjREVmlJWDlvdVJ4ZWJQbWx0?=
 =?utf-8?B?ZHY3and0dnJkYU5tVloxLytyY3VqT3MwZlpyM2E4UHF4cndGVGNHV3NTVEVx?=
 =?utf-8?B?U1BrcC9LbTQrQ2ZBU1R1cGlrTU8vT1V6L1o0UUU1aSt0VjF5dUVaY1Btb3ZY?=
 =?utf-8?B?UENMbGtiOW53cjM0eExSVEhRVWM3cVZUTXhjNHBUN0dvaGVWdUJJNFRkOStT?=
 =?utf-8?B?OGFiMEh1V1hwc0VxZlNmV1pFcVp4d0NGZDRWaHhXSXo5M1I0cERoNE5sUGs4?=
 =?utf-8?B?WnIzeGdROUpWdTYwSHJHQmxDRGxKRUcycGorRFZESUkyZlMzOVNzOFMxWVBm?=
 =?utf-8?B?MUlObEtTWjdSbWZtSnc2R3NtMkJranZ2aVh0QWlNN0IzU0VOWEpINEFVZlYy?=
 =?utf-8?B?RWwzckdnVGxBMzZIUXdQamdtQURLWERPcElNbUZnL2VuaXowUnZ5azdmUml3?=
 =?utf-8?B?dHh6ekRvRmdZT2dZczY4VldIVmlVSXAxUjd3SlpDZ3cyTjlCK3VLZHIrNWF1?=
 =?utf-8?B?TEhnQ0hNS0t3dU5ETjVGZmpIaFpSaW5CZTl6TkdOUlRXUVZiaTdTQUFwVVNW?=
 =?utf-8?B?SGNOdGdHMHBwMk5WakhxZUxtV2ppMEhjcDdpOTlvVVJHVW5MVkdZeEp0aDhl?=
 =?utf-8?B?UVJQTklscmd6eGc4Z0VZZUhIV1ZBeU42djJESnVFZTZ3VWFWNng3M3FTYWE4?=
 =?utf-8?B?cnZQUjhuOE9aRklzOWZ5YWRhU3MvU3lxdEJrRW14QTRucWNmeGNaRERBcGMy?=
 =?utf-8?B?bXZSVmdmbXg3VW1xYnB2NDdLd01HbmNUbDl2S250QXZ1b3pzVTd2UktNM1NC?=
 =?utf-8?B?NXlPemFGM0kxM0E3c2VXNDN4a0ZsNE9tbXZRcGRpSFVmTTFZd0l4SFNqdnJs?=
 =?utf-8?B?NVBzUnFOTXJ3dlFuZUMvNmtqVGxmRjZsZXkyRmQ2d29mREZQemg3Uitla2d4?=
 =?utf-8?B?WGZwWnNzSm9ReUxUVUVudklVTjk4b2ZCYjFTWEFMekFKdkRyNk8rdmRaS0FD?=
 =?utf-8?B?Tlhva0FsdTZSTkZ5V0U5bTJ3OUhzWndieVNnT2c1b1kxNHdNSFk0d1hGcDNW?=
 =?utf-8?B?SURLNWJrdFBYR0FET1hPVk1nVlJTa3BlTStjSGNQN3hvbnFqb2pPN1N0Tmx6?=
 =?utf-8?B?ZFlpSmdmZnRUYzc1TXF1d1ZEMWVMZnV2V0ozRk82cWRUZ3R1Q0Q1U0NEOGdn?=
 =?utf-8?B?OWtFSm5rcjVXK1orK1dkbHZyUkw3aUlQVFBQL0ZiMUFJYkVWQjluZ2UyVDc4?=
 =?utf-8?B?MVQvMnRUWklmOHlRcHhpaXFtQjUrQ3RzSDl1VmQ2THdKN3Ird1lnbXJnd0dn?=
 =?utf-8?B?NjJZaFlFZ2RoZTNXNG1sMlJPbmJIa1drUmZLNWxTY1h1VTIxMldPQS9qOHNU?=
 =?utf-8?B?bkVxSC9VS1lvMDd0T3J1Mm9SRlJmUlJyNVN0QnZCU0JHcDFmcFhadVA4UTht?=
 =?utf-8?B?WHl6ZWZONUJWeWxvU2xsVE5Zc013bUcyUzlFSGVlalhscGNrYXI0Q1ZXcHpD?=
 =?utf-8?B?alNlS2NUUzBvRXE5aG9DR2d3dk1jTDB5ME45cTZUOExsODNmNVlnK3BvMkQ4?=
 =?utf-8?B?bDdJRXQrVmU1MVNmVE1TM29RNzZmOWVqdk92QU9ZamZiWG1pQlROcUxGNG5H?=
 =?utf-8?B?ZVNWUmpSRGNPTGVRdmdtYXc3c2RUNnQxQXpURTk2NEZ6UEhEek1udEk2M210?=
 =?utf-8?B?TGV5MHMwZXJRdC9YaXJnTGpYNFM4aVNnRURoMmVTYzZBY0lkTVJ3SHduODdT?=
 =?utf-8?B?UWJrd3NyMlNpSmNRMHkrRmE2T2U4MU83bjZ0YzNSYW5jMnoxZ1NhYllmTG44?=
 =?utf-8?B?T0N0MjZ1SVFTYjZ6Q3o3b2hGK2VtYmY4Zy8zTW81TmovZjFPZTgyTHBiR3hT?=
 =?utf-8?B?a0ZscnBZdnNuOGZ3S0owakJvbDE2bzVUVUYyN2UwMmcrZDdzNUVYNjNrMW5p?=
 =?utf-8?B?OUNkNEFTbG53bG93clVadHJOMHAvbjJocytYNXlZRzVaWjFOTXBvRWFaU1VU?=
 =?utf-8?Q?9zmmYgPN9WX9/prou14FtzuBOiIp8YiKBQRGt8TI6bLK?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7436
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 94139de70a8141abae251f76a0becf1a:solidrun,office365_emails,sent,inline:8406f9cb3e46051fa2a59ad8ba71cfe5
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ef18cf59-c531-402e-cb96-08de58ce62a9
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|82310400026|376014|7416014|14060799003|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SlIzWHRwYW1BWDhiMTBpcE9aakZ6c3hibDlYeFJDdUs5aGtrdElIZmR1bXp2?=
 =?utf-8?B?MkxxM2pmRUlDSjBsRWFjaFJHUXFKWElJZWpqWGI3RDd2YjVHZjhHcFJQQ0VX?=
 =?utf-8?B?VGI1L2JDY1huK1BtazlkN3pLRlB5NmExSEJObXArRjliUjRVajcrc0xGSnY0?=
 =?utf-8?B?YXZLWUg5aitBK0h4T1pzd0hzQUtMblFWRU80TGxWMTNkeURNTUVzaUZjanNa?=
 =?utf-8?B?SHhTWVhISCtOZnBUTHVkYWFqVlRLdkhLRUJCRGovbVNXalh1VTlMUmI0WXVn?=
 =?utf-8?B?N2lLN0hocFNDR0czSklLRmtpdWdXQi83b1gyQ1NYOEtucUFadUtJUnRTQU54?=
 =?utf-8?B?NTRwVjRhNk9jMjVoSVJ2dzBGcGJUZFBmMDBId0pKUTdaVXBJT3lvR1hsejhu?=
 =?utf-8?B?RlJvV0Y4R2gyZ1kxYkpsNTdsb2I3R1V3bXlBTUNRTnkrTTErYmpsK3JWbXIy?=
 =?utf-8?B?SUk0SWRFcVBlTFN3N09FOUE3bWk0QlRXMkFHT3cxamQ4cVVKbjFmWktuOWFJ?=
 =?utf-8?B?clVtOTFuRXg2WnJLcERQRHZIcTNKUU1GT1QzQUw5UXNRdzdqczkwY3JzelVO?=
 =?utf-8?B?UEYyMzlISnFkaTlTYjdzU1ZxMjJ3UnJmYVhqZ2RFSW44VlUyWkNIcWtuTEM5?=
 =?utf-8?B?L24yOFI3QllTdEJjL3B5RXdmenIvUXEvdXpRQWlGdUp1L2tVQUx5bEM5YkdS?=
 =?utf-8?B?U2loMVZMNmc3d0ZGOGpQMDArbDJZZEFRMUUzL2hlWDZxRHVGSlRXb1ROSHVz?=
 =?utf-8?B?VHJrUXlIVWxmcVFLTXB0V1JyRnJxdGRXSmdPYVVqa3JoeDJMTlpxeVN6N2xu?=
 =?utf-8?B?a0JkMEVnMWREamtYNTRxVkdzUCtQS2hNQ2RNcDVOK0Yrb0FWUXYzdG5YVHcw?=
 =?utf-8?B?Q2g2QzVJY2dsVzNWb1Eya2lHQS9BdHFuSFg2Y292QVNCSWpTanh3aWxiUXNy?=
 =?utf-8?B?RU9veGxEanZyalJWMVE1di9zY2U5cys3dHZyVUNQbzNodXU1UmVZNnFVc0o3?=
 =?utf-8?B?aTg3bWZpUWc0ZFNtYUplZkNId1ZNWUNKcUl5Njg4NWNocVFabmJwTlVaeUY3?=
 =?utf-8?B?djVtdmkvYTBWTVJFY2tkRUQ4NWZtZVRmQ1BDb0pOK2dmYzBJV2ZqMjVCV0xE?=
 =?utf-8?B?L2tZSm4ybXRIV3JXdDhCV3pMSnZIY3IvTmxkUlppWURyM3cxViswekRQeW5a?=
 =?utf-8?B?VDRwY29MczJPL1JMZkcvdytMNWdKUGRHM1FMMGpKK1B0NjdmeWJGRS80UEFM?=
 =?utf-8?B?YjlISjNVL2tCd0VqdlBBcGdyUHRSWTFURHA3L3YrVnhQU3c0Wk5ScEYxSTJS?=
 =?utf-8?B?ZHNrWXVRTk9zWXl6Z1hXZVczT2hJMy8vTVd3N29raDlBcXZobEp1K0UyYUJj?=
 =?utf-8?B?UlMxZC93dzVqZExZOXJKYzVnZnJiUFZnSHJLOTZLZC95bGdreisxR2JKL0dD?=
 =?utf-8?B?b21PUi9zK2Nka0VxWFh1ZVBmSmVaMzNFTjZpZWE0MWVtcmI3V3lFeDJ2cnpP?=
 =?utf-8?B?NEtNOEoyaDdMZ3pkb3FHQTdFWFcwTnhielhCQlN0c3B4UUs5WEV4aHVGaUJa?=
 =?utf-8?B?bXlVd2M2U2d4aWlSZ0U2akpWejQxQnNOSEhmOFBQVG5hSjBDaFpiejQ2ekRy?=
 =?utf-8?B?OHlqSXhoSDhjMDVRTW52ZmYxaVpwNlhFc3VBbVJUQnRTZy9PRk1OeGsxajJs?=
 =?utf-8?B?ME9qd0FkR2l0Y0RxVlFHWW5qNTBPWmZZVldGcUR3bU11ejBWbXNqSkUwNFBn?=
 =?utf-8?B?M2ozMWdtazVsaGdtbEZpc1VoTG9reDZDbEovdXN6eit2UjJiYURQMU1WaFFU?=
 =?utf-8?B?cW1aMnV1bkQ3WDkvRVN0SXE1Kysydkp4WVU3MVR5K3M0NkM1L3hzY0kzNHda?=
 =?utf-8?B?WE93M2lFZDdCL1RaMWg3Q2FRejlOZ0JEaEdiaWM1Z0phYzFYbDVUL0JaYUpp?=
 =?utf-8?B?Ukw3RGRoNkJZeURSc2ZFN0tkRUJST3Jaak9xWGxDaFRETk9FMC9mV21XdDJO?=
 =?utf-8?B?R0xmdjl0OHcvUzlpWDFzanF0bkJFd3pPQXB2a0x5TW5QSWc0VlVxRVNnR1Zp?=
 =?utf-8?B?Zks0T0tsZXU1V083ZDhwcVJES0NSd3A0WUlHazRSc1I5d2p2LzZHcmk2MjZa?=
 =?utf-8?B?T3RCbVpwZ3dERUJ6blViMHFPRnlVOGo3My8rcGNoczQxTFl6bTJmNjFUVy9V?=
 =?utf-8?B?RDVMbW5iblVjSkx3K0V5am12RVB6Zk5pdEQ0Ymt1SEhnbThDbVphT3pKTk9N?=
 =?utf-8?Q?RvgPa+RMt51HBUpBCPBJd+T+UGu1xO5CkcewXD07pg=3D?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(35042699022)(82310400026)(376014)(7416014)(14060799003)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 09:21:05.6030
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8eb82d-7471-4667-f321-08de58ce6784
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11825
X-Spamd-Result: default: False [2.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=4];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : No valid SPF, DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6240-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com];
	RCPT_COUNT_TWELVE(0.00)[32];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,solidrn.onmicrosoft.com:dkim,solid-run.com:email,solid-run.com:mid];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: B126954914
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add help text for CONFIG_MULTIPLEXER to allow enabling this option
through the kernel configuration without explicit "select" driver
dependencies.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/mux/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
index c68132e38138..b2e1abc7c910 100644
--- a/drivers/mux/Kconfig
+++ b/drivers/mux/Kconfig
@@ -5,6 +5,14 @@
 
 config MULTIPLEXER
 	tristate
+	help
+	  Generic Multiplexer Support.
+
+	  This framework is designed to abstract multiplexer handling for
+	  devices via various GPIO-, MMIO/Regmap or specific multiplexer
+	  controller chips.
+
+	  If unsure, say no.
 
 menu "Multiplexer drivers"
 	depends on MULTIPLEXER

-- 
2.43.0



