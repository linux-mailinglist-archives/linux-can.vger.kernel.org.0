Return-Path: <linux-can+bounces-6523-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DOMEQPdiWmBCwAAu9opvQ
	(envelope-from <linux-can+bounces-6523-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 09 Feb 2026 14:11:31 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DCA10F77A
	for <lists+linux-can@lfdr.de>; Mon, 09 Feb 2026 14:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30AC4301F9B4
	for <lists+linux-can@lfdr.de>; Mon,  9 Feb 2026 13:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C4D3624DE;
	Mon,  9 Feb 2026 13:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="aG3RlTed"
X-Original-To: linux-can@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021142.outbound.protection.outlook.com [52.101.70.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7372459DD;
	Mon,  9 Feb 2026 13:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770642545; cv=fail; b=npF+iIyDKdEwTS7RlV/c2A+CM3ZXFUsRFgDjuuBAuuKUODYONsQ3ipMYasrrq1j9EuOMEn7FxbZWZtL7CTE7Y5D/QtD7Szy2/woh3DJ15O2tA3qJylr3BUFy9aYyTLlOaDi9siwrKqj5/zgs2hPBhQ/GSG5rifXuUFXuUZmvmLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770642545; c=relaxed/simple;
	bh=0VvVemr90f5p1QfU+Jad16rzvZ12O6L1//HUM1Q10Q4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ot2lsrqLKB0zlBZts3LI2tKMiLwki4R4qNRB5/0V11VALMWp4eNIRU6kMufesbBK1X/7dgssQuKed7L7aZwxQ0zTz3bTODuIkuBlDqAVgN9Dlrg8iKY5lEPa4KAGTNlz1lx057WuUXxm9eaS3xTswrEMHaZAnTEdEJrRRtvyi5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axentia.se; spf=pass smtp.mailfrom=axentia.se; dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b=aG3RlTed; arc=fail smtp.client-ip=52.101.70.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axentia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axentia.se
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qQc8oIoGKAdN3Tx7YlnVkMzV9kerYl7OTi6KbSLl1XK3CjoPTjVe94aut9oOicRBY0NehZtLUpeg5YSKSD70fG8WUsrsHjNN/4WeOZhQfrbHCrQIWWUmXaOnRkzruHAu2pwHYfwQCnzgQzCi3Kse1+5bBjEYTyDD3vvKOWTalUVJVaanRGMm3OS1jZhmUrPOfBg3MQEo4f4jCLs9O18Xj2uvWapAUsszNNrDyJk5TOnWLu+t7A//lfMVzjkmNpIpWQG5e8s/jXKefM7vbdM+YJL7TzSK/o0MNsLrChR48b+lXmdfwin201CmAhOcC0mpxTECeJdyEZ3j+3wpuXzaLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ka02QMcvZ0nJz/HQWiv0qkORZoFCcqNdVRHreRDNrak=;
 b=tnijYhPkFQWB28qZ9KaOx+qZfViw16fJGWyKCWubCKqqWQDsLGXOeQlsXzly+fv9BDqt7dQoXxSFugTF7CUEePwqDFkxJ31KtdAY+HdpvAUmPe3B2cT9Xe7lqQJQswQYtGxgpwA3Xsmu2G/uELsINF48ulLDhGBiNr4tzDdVJLyyB1V02NL+VuPq2WTBVaOMJFwXT4SWifrH4hZ+wUUpsFzUhwaXa/lvEF9mtiSKnTlxH/SWsNRw+GG8YyaMe2hUIle91HDvtyqNgT+FhHHUl/xVbkKA8+LYX8wQOGG4+elCTw+Q9VFb7M7SP29b/C/dm1KRAftlje8e9di0m3VEPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ka02QMcvZ0nJz/HQWiv0qkORZoFCcqNdVRHreRDNrak=;
 b=aG3RlTed6lq7+sQZ5uCDjSAbLgxf/Hr9if8puBvuIHNTjSOvTtKi+T1IZX312SybjsxClZZt3b4gx46Q45r8lkmFKCbgJ7TAmToRlbvmKb18owfU/ytba+zkbqPx2bt9CsL3kS6TfrTfysgY/lFYuX7oHVicDMYHBgaIHWI1j5A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AS8PR02MB9235.eurprd02.prod.outlook.com (2603:10a6:20b:5c1::5)
 by DU5PR02MB10516.eurprd02.prod.outlook.com (2603:10a6:10:51e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 13:09:01 +0000
Received: from AS8PR02MB9235.eurprd02.prod.outlook.com
 ([fe80::32a9:a9e6:ded:5714]) by AS8PR02MB9235.eurprd02.prod.outlook.com
 ([fe80::32a9:a9e6:ded:5714%6]) with mapi id 15.20.9587.013; Mon, 9 Feb 2026
 13:09:00 +0000
Message-ID: <f4d8547d-3de3-0de5-da61-3de57d9af895@axentia.se>
Date: Mon, 9 Feb 2026 14:08:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v9 3/7] mux: add help text for MULTIPLEXER config option
Content-Language: sv-SE
To: Josua Mayer <josua@solid-run.com>, Marc Kleine-Budde
 <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade
 <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>,
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
 Mikhail Anikin <mikhail.anikin@solid-run.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
References: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
 <20260208-rz-sdio-mux-v9-3-9a3be13c1280@solid-run.com>
 <bc5fbfc5-6f71-eeed-ad90-0c1b835e65ea@axentia.se>
 <fcef2798-1645-41fb-952e-daf3657bc231@solid-run.com>
 <704210e0-2e53-09f6-9f8c-3ae0c4b8e0da@axentia.se>
 <9d7bda92-e520-466a-a0be-d01686af1d56@solid-run.com>
From: Peter Rosin <peda@axentia.se>
In-Reply-To: <9d7bda92-e520-466a-a0be-d01686af1d56@solid-run.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVZP280CA0031.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:276::11) To AS8PR02MB9235.eurprd02.prod.outlook.com
 (2603:10a6:20b:5c1::5)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB9235:EE_|DU5PR02MB10516:EE_
X-MS-Office365-Filtering-Correlation-Id: 12fd7c62-2289-48ca-2141-08de67dc644f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azZwNEdBVm42dmhhWDkzNnc0UUphTXlsNnVjM0hiNzFxQUJtc1Z1ZjJ0OWhk?=
 =?utf-8?B?bVgwTUNYaDZ4NmFEZXF3R20xUUpNdHVJR1hPUEVGU01XbUJwRWJhL3U3aVNP?=
 =?utf-8?B?WThxOExpamZnb2ZQblU5UWpUVG9jeUYrWThTOHNUQ2trR3hITSszcm5IMlJR?=
 =?utf-8?B?dGNXUG1nRXc2d0tGQmwxUW1TcFozc3JwR2F6cUNhZnBHTEhLY1lKZUZPMmVG?=
 =?utf-8?B?dUVEc2pXVzR5c2p4L3Z4aGZWRGR2TE5hWk0xMlZacHp0OExDbDZxWTkrcHJN?=
 =?utf-8?B?T1BIQ3RoWHk1cGtFd2dmSHRKQ202OUY1cTR0cUFHQnNSMHJPRXFnai93b3Fq?=
 =?utf-8?B?T0tyYnFXbmpGcnFZVm81S2xzUTRheGxLY1JobGxrZkphcENubWthak5zZEl0?=
 =?utf-8?B?WlErL0hkMU9zZTh4Z2pYbWIwa0E2b0t1aUxidHhiVDAwVm5OWGlSN0Nza0Mv?=
 =?utf-8?B?a0xaWE1MOGR3aHRYd0Z4dkJsUjArMU1RRUtsdVlJOUcxS3R0TTgwSDlGWHZR?=
 =?utf-8?B?VVJEZmVTSzNMd25ndlNMQUZUcG9SWi91d3RlWHMyN0VKbEVBU21uNVRCaXNh?=
 =?utf-8?B?a0hIMXgrZ3VGWGdocVIyY3luZVg4Z1hHOVlGblhoOHVRKzJjTXBkSlRWK3Z4?=
 =?utf-8?B?ZkZrMUl3M3RqdmpFWEJEOG9IYUhaaENMNUZOdW83V1cyTmFkYkpQek1uOGN1?=
 =?utf-8?B?OERyRHdQOUxROSt0djZaMEROSHdiNmwyQWJOVUZYZDNaWTlrZS85cHR2dW4x?=
 =?utf-8?B?RDFnVHhzUEtoTk1yQmtjK2EwT0VpSGNEMStsY0hULzlENllMenZXWTZZWW01?=
 =?utf-8?B?YVdIVzRBalJCcXJwdXZFaDB4QXNqQ0x3aUhIMHlubldlWi83ZFprK0xuZFc2?=
 =?utf-8?B?Q3IySDZ0MER5OE0yY0M4UzVDWUw2R0FIQy9CV3FsZ3FwV2IrQXJyd0xOcVhK?=
 =?utf-8?B?Zld0ditFYkpKcGxCNkZsanBVNllpZ00vRWhvNGh2d2hsTjZwSWZqTFEzR2VJ?=
 =?utf-8?B?eS9aVWpQUGtmeUxRT0FPTlZuYU5tdmlvazVaYTVhWTY0NUE1Rm1tN1BnUmZk?=
 =?utf-8?B?Vmw0emcwMHNqbit3bjJITWk1dS81b1ZicDIvVnpaeUFobFVpMC9UaXFXeU42?=
 =?utf-8?B?VnVzQ2dGYUZmRnNYMzNUZG0rcldXclVPNGZoRU53Y1Y4MnpJWStVZHk3YzlG?=
 =?utf-8?B?bE5CV0lTbzdpbUJzM0Nzdm4vaHJ0RW9zRmdhTC94RW8xcWNGWnRjMHErT3F1?=
 =?utf-8?B?ajBnb3RSckFjMUZJWUJva29qMkQ0YnhET29jdDd1TDMveDNMdjFwM2RPZmho?=
 =?utf-8?B?M2VxZjNmT01WM3h6M0RJQU9TVXNFZElsZTNFSm1zdzdiS2NmMU92QWlROERm?=
 =?utf-8?B?ODdoSm5aWStQbm0vTEVuZ3kwdk5pMEowYmo1and5VHo1QThyY01EWG1FNzNZ?=
 =?utf-8?B?cmpBU2U5MUJYeWJEb1FjcW5peFRzNUpRWmJFeXE5ZEhYcFNQbjcxeklCaVo1?=
 =?utf-8?B?UTJiZ0NtbUJSbVpGYzYwWkdvK2FGL0ZRZVc3MWpHeUp1ei81clMyWVd6bDBM?=
 =?utf-8?B?dUJPYmxNbzl5WCtVbkljbVZUS2swOUtTbUhZSHhGZExHUy9IYm04eTBvbmlK?=
 =?utf-8?B?VDBrQ3V4by9HMHpuWmk0Nml5cW1rc1h1Uk9uUklNQVVxSWpqK3R3OGpvWXUr?=
 =?utf-8?B?ZzdxSTZIeHMrUGM0MzVnN09mMjF6YVg5TC9MK1lqc21DSVc2eEcrNDFaQkJU?=
 =?utf-8?B?MTNMT3R5bER5Uzh2L3A2dWhwSFNNZjBtZi9QdVAwZ0c2VDZuUkhKTnA5dU1x?=
 =?utf-8?B?WjZ2T3p1MFJ1VkdBT010OXNET2xEYmUxMm1YdnF5OVJralFmSmNMMGc4Mk9J?=
 =?utf-8?B?aWtQU3owRDFRMngxV0M0YzQ1aE4wT3EycjJLS1QwTVJSeXY0SWp3b2lTZEVK?=
 =?utf-8?B?SkhydDVBR2ZTNCtETmo1MHJydFdoUUczWWYyUkorOWZQQXNheWt1Q3c3YktF?=
 =?utf-8?B?R055YXZPVG5LQnJhc3JLN1AyRm54RUdjYjJRQktkOE5YVEh5ZlJhbmhOa1Js?=
 =?utf-8?B?b2RHSWc4WDFIdHFVa2hsa0hDaWRqWktFdFN1dnEyNWxLc09lTHZhZ3RNZisz?=
 =?utf-8?B?UmU1VFdYVllDYzN2R0RqcHMvb2RETU53Z0NxOXJBaUZCUUk2elZMTmpCK1kv?=
 =?utf-8?B?REE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9235.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djkyYWNtQXdGa0hOcVFocVpzcEcvS01EZVlwTEU5WjB2SGt6aDhlQ3FldXdi?=
 =?utf-8?B?RHFxUHJSWXp2alJqQktxaXN4bm1DbmlhbGJoNzlKN243ejUvbkVZTWNyQzls?=
 =?utf-8?B?QndZeEVnMWpkY3BDVjFqaVhuWkYxV3IxVDdGek5keHkxdStzLzVFZXhPb3pi?=
 =?utf-8?B?dWFkVW0wdWhDZTVqY1REWG1hbnhlRjAydXVuakI0eUxhOXlGaDhEdVl2cTlq?=
 =?utf-8?B?bzRFMTcxU1ljbmhGTnlaYkIvYWtlbVpLVzZxSjViVDdnNjBCSlFGbzM2dlNO?=
 =?utf-8?B?V1VzQlJibEdBS3hYa1BSMkdGNk5kNEdDSllsL0hrMUpJTDA2RmtjK2tWV05a?=
 =?utf-8?B?STlxZzRieUFMZVF1aHQ3NzVKbU1Lamt5OTdJNit6TmJoSC9vdXUzbnp0c1lk?=
 =?utf-8?B?ZkdRaU5rTStTVEpHTXVzcUNkZU1nUTBncS9zRGxMSklwOTFNSkh5eEd5U0ZE?=
 =?utf-8?B?bjI0QlhMazlYbmtxVGRDanl3d0p1ZzVlRnZCMm50T2J4bXZUQnpIWVNEUzJO?=
 =?utf-8?B?QTBueHRoRTJ6dHFBb1oydkFKWWowU0hLdGJhZngxd3E5ZHFZTlQ1R04yRFJS?=
 =?utf-8?B?N3RkOVAvYjczUnljcnhKZ2w0MUNndU5nNUM1UWZlbHMrTkt0ZXBocE9BN3Jh?=
 =?utf-8?B?dDhudS9vUkNoTkM4alI3RlRVZ0h3d2ZOdklKcGtrZTR3TkVTd1hpNVBWMnkv?=
 =?utf-8?B?T2Y5S3RMR2tSZm4zWWhPc01CM0FzTVQxOGMyRTU4VytMSnJXNVBXdUNhQUZD?=
 =?utf-8?B?UGRlRUZNNUtwbTRuUjZnMXJuL1ViN3k5MndTMFJUQ1ZvQlRmU2NxMWprZzJL?=
 =?utf-8?B?WWRrcWlYMStZZVNHanpkTllvbWVlOFRBZmRLMnBrR0taQTRTU1RCNTB0OFZ4?=
 =?utf-8?B?QXJKeFpqMUc4SnBkblA4NXVScU9lN3lnVFNZUXN5WXpqbDdyREhYRFNsNEtv?=
 =?utf-8?B?dU5sQTVVN3J5QlljSytqZ2lpQzVVSUNHSUlCWUlTUzM3Y2I2cnZ1VHM3OXE2?=
 =?utf-8?B?MVNpdEN0UXhBbTlKcnRFOFZPRmZ3QmN2ZGNuWWpGVnZUbG5MbkViOVNUa0k4?=
 =?utf-8?B?dWkrdGVUZ2RNcThwQ3pNcG1YbzFRcEdCWHJGQ29tcjcyanZSV1VUclByZ3Nq?=
 =?utf-8?B?ai8vV0FkWkZKNTNHeVViUnpQYU9yK1JxSnZlSWNicWhiQkhDV0lTVmJxMjc0?=
 =?utf-8?B?dzhUSlB0SnJnenJOcVZFWEpuYi9McWJPNGswWko0SkR2NkdWM0RKZlc4cTNX?=
 =?utf-8?B?Z0ZIRFJCWG44MWdVSEgwVFIwS1hQZXlEUzMwYkRpR2FQTlNIQ2htWjU3ZkFZ?=
 =?utf-8?B?Y3FtbjJCbS92MlJTanJpVDROdlNBMmVHNG9zY1lhdEZ1QUJhdU80ZVhldEFQ?=
 =?utf-8?B?b1JrWTBtSVFySjhDRjAzRWFMeGF4SzFhVXhRUlRNV2IrYm52SnhqbWNzd3Bi?=
 =?utf-8?B?ZmV4M3pXWThFMFV2MTRneVBGWWlINWk4Y1prNzBaWlZIQ29zaEU4U3Zrc0Mz?=
 =?utf-8?B?d1l5TkE5R0d3azFGOWZYRjZ6Y3FIYnA0QnAyWVZuMkQxM1EyOVFnNGdjd0sx?=
 =?utf-8?B?SnVJTFZNVUhBYmlBRm5HWG80cGRPRndVa243anhvYi9FaFJuSTlOZVNab2RL?=
 =?utf-8?B?MXVhdEo1L2tEZWtmekprSHRyTjh6OFR1WnhLWEszZVNxU2J0TlFuaEN5NW45?=
 =?utf-8?B?V3ljaTJVektKV2dGQmN6eUJZODdXV3N4UUd4b3VIVXNGR3dzbVhDT0NacjRR?=
 =?utf-8?B?T3N2c1BZSHh4QmxOMmxxVStYaHZmWTdEWVpReHpvdC92MWdpK0ZkTHJHUzJE?=
 =?utf-8?B?VFNKekNxUElucm1SaklkMUhlTCtKQm5vSlIxVXZNVWxlQ25WZDJmTS9MK3or?=
 =?utf-8?B?cFd1akZjeWhNeS9HSElDT3Q3N0diTCt0OE5XaTlWTHBOcHBCMjNYMm80Mml5?=
 =?utf-8?B?YXhmem1vRmVWSExOeHVwdVpjem1OaEMzbURlUVlZanljUm9yeEVlTTlDNWxG?=
 =?utf-8?B?THVyais2aTcxNGluTGlGUkQ4OEY0ajZQQnRqeFpEY21xU3RpL0RvVmlYdjRl?=
 =?utf-8?B?cTNqSHdsMzV6S1c0RVVmZnk0aUU0WS9HeFpOTnkrVjJqK0xORnUvalRSVW9Q?=
 =?utf-8?B?aG9senAvOEliQUZxTjNFVzhOd0ZtYlNQSmI1OVdrcFhxTVkxSFNXOWRxNFdM?=
 =?utf-8?B?endaYldwOE9oWUlLUU80S3Y4TE9XNWRlQmFHTlY5R2s3cHlYUjEyWmtWcE9w?=
 =?utf-8?B?UjFhdlRpNTlaS2xxbGtkcmxUc25tczM0YnppUWwxMy9wOXBVUkMvQkh2eitp?=
 =?utf-8?Q?2ktBqQ9qxpPvbwxBUK?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 12fd7c62-2289-48ca-2141-08de67dc644f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9235.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 13:09:00.8546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WEoQm5o0AznoQEWcpEE6O5tkenfFeiuooID9kTFBc4+HwG/BLeUIrJ9StMY5smU0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR02MB10516
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[axentia.se,none];
	R_DKIM_ALLOW(-0.20)[axentia.se:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6523-lists,linux-can=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[solid-run.com,pengutronix.de,kernel.org,linaro.org,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peda@axentia.se,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[axentia.se:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[axentia.se:mid,axentia.se:dkim,solid-run.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D3DCA10F77A
X-Rspamd-Action: no action

Hi!

2026-02-09 at 13:07, Josua Mayer wrote:
> On 09/02/2026 13:43, Peter Rosin wrote:
>> Hi!
>>
>> 2026-02-09 at 12:31, Josua Mayer wrote:
>>> Hi Peter,
>>>
>>> On 09/02/2026 13:10, Peter Rosin wrote:
>>>> Hi!
>>>>
>>>> 2026-02-08 at 16:38, Josua Mayer wrote:
>>>>> Add prompt and help text for CONFIG_MULTIPLEXER to allow enabling this
>>>>> option thorugh the kernel configuration without explicit "select" driver
>>>>> dependencies.
>>>>>
>>>>> Select it by default when COMPILE_TEST is set for better coverage.
>>>>>
>>>>> Signed-off-by: Josua Mayer <josua@solid-run.com>
>>>>> ---
>>>>>    drivers/mux/Kconfig | 9 ++++++++-
>>>>>    1 file changed, 8 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
>>>>> index c68132e38138..4f7c6bb86fc6 100644
>>>>> --- a/drivers/mux/Kconfig
>>>>> +++ b/drivers/mux/Kconfig
>>>>> @@ -4,7 +4,14 @@
>>>>>    #
>>>>>    
>>>>>    config MULTIPLEXER
>>>>> -	tristate
>>>>> +	tristate "Generic Multiplexer Support"
>>>>> +	default m if COMPILE_TEST
>>>>> +	help
>>>>> +	  This framework is designed to abstract multiplexer handling for
>>>>> +	  devices via various GPIO-, MMIO/Regmap or specific multiplexer
>>>>> +	  controller chips.
>>>>> +
>>>>> +	  If unsure, say no.
>>>>>    
>>>>>    menu "Multiplexer drivers"
>>>>>    	depends on MULTIPLEXER
>>>>>
>>>> I'm not comfortable with making MULTIPLEXER a visible symbol. It is meant to
>>>> be selected when needed (and there are a dozen or so instances). The kbuild
>>>> docs has this on the subject:
>>>>
>>>> 	"In general use select only for non-visible symbols (no prompts
>>>> 	 anywhere) and for symbols with no dependencies."
>>> The patch description didn't make the decision logic clear,
>>> and I plan to submit a standalone patch for this after v7.0-rc1.
>>>
>>> Basically existing drivers using mux core used "select" to enable it,
>>> even though the core can function standalone with device-tree.
>>>
>>> Some of these users (phy-can-transceiver) function perfectly
>>> perfectly fine without mux, and use it as an optional feature.
>>>
>>> Likely drivers only used "select" to avoid writing helper functions,
>>> prompt, kconfig description and stubs - which this patch-set added.
>>>
>>> So I will argue that some existing users relying on "select" was wrong,
>>> and that the mux framework is generally useful on its own.
>> When I wrote the mux sub-system it was very much intentional and by
>> design that drivers needing a mux should select MULTIPLEXER, and that
>> MULTIPLEXER should not be a visible symbol.
> Need is a strong word here, and doesn't address the optional case.

"Need" was the correct verb up until you needed the subsystem to be
optional. If you need the mux subsystem to be optional, you need to
do it in a way that does not introduce headaches.

>> You say that it could be useful to have it visible, which is all fine
>> I suppose. But, you fail to address that quote from the kbuild docs.
>> Why is it OK to have the preexisting drivers select a visible symbol,
>> when the kbuild documentation states that it should not be done that
>> way?
> 
> It might have been okay for a transitional period.

What would be ok for a transitional period? Introducing potentially
problematic kbuild dependencies? I'd rather not...

> My original patch-set had already exploded due to the request to
> introduce general purpose devm_*_optional_* helpers,
> and the fact phy-can-transceiver already had a local version of the same.
> 
> So perhaps if I will submit a patch-set changing to visible symbol,
> I shall also change the few drivers that are now using "select"?

I think it would be simpler to introduce some new visible symbol
that triggers select MULTIPLEXER, making it perfectly fine to
leave all the existing select MULTIPLEXER users as-is?

Cheers,
Peter

