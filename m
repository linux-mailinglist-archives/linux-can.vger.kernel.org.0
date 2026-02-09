Return-Path: <linux-can+bounces-6521-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAeiJr7aiWnMCgAAu9opvQ
	(envelope-from <linux-can+bounces-6521-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 09 Feb 2026 14:01:50 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CF010F523
	for <lists+linux-can@lfdr.de>; Mon, 09 Feb 2026 14:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DC5FF3001A63
	for <lists+linux-can@lfdr.de>; Mon,  9 Feb 2026 11:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1816536F43C;
	Mon,  9 Feb 2026 11:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="d705fDBH"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023100.outbound.protection.outlook.com [52.101.72.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E82E36E493;
	Mon,  9 Feb 2026 11:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770637405; cv=fail; b=c8M7D+Se7CcBN/f6K9rNh8/opnlP+W+ZECCVIY0s9HDfBvNKxiOptmnbjjhtMqQmIOtZSRRDsoBec2kmya5I9B2lU00k+izl/DX2vCnkyZp9iJCGT/tngDVcPrwWzyrr75yE2wljNjZ93GXgOfQNKmDohI2dDy3juuQqf5gHJg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770637405; c=relaxed/simple;
	bh=XyxryrIntXqGxF5jCaf2UD/DGkBg5dotp6SMIq2Y+Ck=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PW2jvUblgphBfcBaSV5Oa8Y7EVhmw4SeS1rLnbAvkIEhIAfWpRGt5L9Uel3xbntY5PmtXZgJ5c0o0rIFOKaii0Ejganrf9LiyIWnuYH34DHQiuTtRQK2rUkXqIs1dyGsI40zzcpK21UdJuGDgS7rfPwXBRaE7S//2t1nKsm+Gpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axentia.se; spf=pass smtp.mailfrom=axentia.se; dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b=d705fDBH; arc=fail smtp.client-ip=52.101.72.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axentia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axentia.se
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AngiA4OT1yp18T7G1TKJl67TIqUTnRFgoybA/vRbrLELeQaAxjtxpTFxQMgyFMHp+tsfUHDwCCdCoNS/F3vJRuzO2HWCvqeN8GImW8s/l52trez68USiosVQRdpCraECK1HU+3IxqyXePt9F0gDNdSQ30JLvs5LmV+3sbKI389Og3Q3nEzEJXVmS5flNa3vikcm2zaje6hecgq+adDBbA3NDMBB7SwKHWdn8hWWdN3YJD2yQi7TH8YsP3atBslmpVHX4iRB6ZSni5RHQD6IhostLF9JXxf0mL+z4XcLZsDTLTq3gZdOTeADceJ1eatZ6Lrq9nqUtD38ChWZPm2nxBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhmVV94xF4ifvTGPkEX/p1D21emeiux39HefhuHKBlY=;
 b=mXgcL4LpoMkV/GRYpKtyH+1Ouz+oLW2sIo7GQmwkVDUXrj0EHxsrYQ5pJjpSBc+BTCx/Onlx9Z6tjyIm8s6a+oCq2pTHgvNRAmDcyFHE2xP8ykacZz8Gutu3+odLK7K1Dhl2FbRXrjr50bDDK/Hpy6vetBE6DgBBHAckGf1ADSA019pitzXXywiwD2uIEpcIAaEkIQp7/FENHDvDzT122I3naJef3xDTATNx6ZR6EexrkRjke1hO/hSjoffz41wUG2r+SDERYb4rrkeRgNQA/fNSCuybmlhDq8NspzHy5vIsTgpnDAKuDM6zRCKjU94Jpcdc4UmPKDQsNQsTelKkvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhmVV94xF4ifvTGPkEX/p1D21emeiux39HefhuHKBlY=;
 b=d705fDBHoQEhJy8xFMG8Hq3u2IiwR535WvGQR03HPXqiUmumy18ybfTiSGEAPIu/sEFmvk/BQH0Qbc7Ilm34UQU0P+PoteCaU0nPatMYEozEq+e4xeUUSLaIvdumdQ6CDRn5/E8LroMQrxUPinC/f0rHWB1O8Y2llIHL2HC5IP0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AS8PR02MB9235.eurprd02.prod.outlook.com (2603:10a6:20b:5c1::5)
 by GV2PR02MB8458.eurprd02.prod.outlook.com (2603:10a6:150:a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.16; Mon, 9 Feb
 2026 11:43:19 +0000
Received: from AS8PR02MB9235.eurprd02.prod.outlook.com
 ([fe80::32a9:a9e6:ded:5714]) by AS8PR02MB9235.eurprd02.prod.outlook.com
 ([fe80::32a9:a9e6:ded:5714%6]) with mapi id 15.20.9587.013; Mon, 9 Feb 2026
 11:43:19 +0000
Message-ID: <704210e0-2e53-09f6-9f8c-3ae0c4b8e0da@axentia.se>
Date: Mon, 9 Feb 2026 12:43:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v9 3/7] mux: add help text for MULTIPLEXER config option
Content-Language: en-US
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
From: Peter Rosin <peda@axentia.se>
In-Reply-To: <fcef2798-1645-41fb-952e-daf3657bc231@solid-run.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P192CA0010.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::17) To AS8PR02MB9235.eurprd02.prod.outlook.com
 (2603:10a6:20b:5c1::5)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB9235:EE_|GV2PR02MB8458:EE_
X-MS-Office365-Filtering-Correlation-Id: 91cb5a91-2046-46f8-1a84-08de67d06bfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFE5eW5Ddm1RR2NOaDNuVHhPL0RCRldxVkV1VCt2aVZtem01cXFjMVBqRXNC?=
 =?utf-8?B?YnhYdVpmQ2ZCeDd5clFuQVlNUjJkVVl4VUVvZW9TWFlETVMvTDB2YjNOUWJa?=
 =?utf-8?B?RWVLN2NyZUl2b0k0aXVHbGZzQ1U3RFdsNEZ4eHNBSFgyS0VIaCtMemw5T0tv?=
 =?utf-8?B?c1FFdEhPdXNnV2U0TG5lMXc1cm9TZ3p0ZCtpbEZJUzdrWkRnMWt4OWNNc0ZW?=
 =?utf-8?B?VkNwU25pNVhmcTZXZEVCR2FRdVF1blpaRFhLRmVwTEE1K3J5UXBYTnBoL3hh?=
 =?utf-8?B?RlUyTWF2Y05JMWh5OVF1dnJHc0UrclFCdGYxdWJUbVR4czQwVGt1L05pRy9O?=
 =?utf-8?B?Q0EzSVo5SzN5Sk5LZDVUYm5oVTFLWVBBWThFcUdpMGRqUXRReDVKeWRtZ09p?=
 =?utf-8?B?T3c1MUh4VlVsdTN2QlpRNzd1eDRDZ2F6VTlOcG1PNWRWdW1HYStraFRMcW9k?=
 =?utf-8?B?Wnh5a0dkZ1RaZXRYL0F4TnFPakJzeDhPeUxLTUJLK0R6MzgzVFBxeThKR2tk?=
 =?utf-8?B?c1ZBYjl5cmgxR1JuK3RzNlZ4ekJBSXBSWFJJRXptZUpMdmNzTUhsMzBUNjRF?=
 =?utf-8?B?MnJ0UnFQVi96eEFKT3VXcTFVamVaNThmV3BPai9kU3VacTI4ZVpDOEhBcnM0?=
 =?utf-8?B?VGFXTXMwU0JLMEh5d0xITUhpMkpmaUxoR0VUZDQ3ZFlzQ09oN3hwMi9UaXVW?=
 =?utf-8?B?NXZ2c3phbXpKSmtMSnJxb1BMeU02K004M051bWMzcmEwVlBQeWRyUXRXUGFv?=
 =?utf-8?B?K1VoMTFJQnIwejNRelRoVG5JVWNlQkFQM0Zya0dNTzB1N2E0c1JWM0dzVXcw?=
 =?utf-8?B?SWp3a0NQS0dvZnI4N2J0bFVseU5wcHV3OSt1WlZDQkZjYm8yY0Fua2xWZ3hz?=
 =?utf-8?B?RHFFak5CSDFrQ2ZwVkdsbFhGNHJ4Q25wcnQ2OVNpS0l2YjRFTThYTTFSV3dN?=
 =?utf-8?B?MzAvd0dUY0VvSDFid0d5aGNyUkFPS3Ezbk5SNnRpaFNCQnNpVy9tUFVidy9y?=
 =?utf-8?B?NlB6dW4rWWlqZUhVZWIrR3AxakpnL0tOVW5qNlZ0SW5IVjI0TnJ5Z0xEUWVC?=
 =?utf-8?B?Q3doc1ByUUNEU2h6dnhPT0pITzVyWmQzRUk5elRmL3hGcStnQzc5bHdvN1ZE?=
 =?utf-8?B?WmRFZ1NqQnQ1ZDJ6UWlVNFE0RUpMdlgzZkp2ZWlyeFFrQmFmL0hid0JvZXJO?=
 =?utf-8?B?MzhnbjZmUXZlajJxSjdUa3VUUGtaRS9rWWJrbkFIM21vYUZWa3BKZG9KcVF1?=
 =?utf-8?B?UVYzcUpOUjFEYStNbkFCMFZHQTB4akJid3Y5bDNyRFgyT201V0R3TEJ6bndl?=
 =?utf-8?B?UXpGOGtGL0hOY0t6U2RpaHdSSHRQcFFtVGgwUnE1cnlDamZRU215ajkvdGRi?=
 =?utf-8?B?VXVIVm1SVXQxcUZNbWNWVitpTmZkTGVRQkF6dTBTckpwaWdFYkpKR1M3ZXhZ?=
 =?utf-8?B?NzFpZmgyZzdBTlBhWjBEWHY1eTlHMk5rY0VQVXVhemEwcWZvcThqN0NrVklZ?=
 =?utf-8?B?cW5PYzlMcUxSSk1rMlNZa1BRWHFwdmpMMFR2cEJPWS9ZZ3dwZHZ3dHcyby9L?=
 =?utf-8?B?TmZDMDlJWjhER0J0ZmhLeTlCRTRsZ3pCNnlOeUhSTmpOOGE3NG1CbVNIN3Ro?=
 =?utf-8?B?cXRWQ01aR2JhSlo1NXp2aUx3UGFXSGxhcmVLRU0xemdaZWR5K3QzeVFvQ1NK?=
 =?utf-8?B?OEExcXRla2V5Tm84QzlIWUNOaFplSXJJTFF5L2NrOGhid2ZVRC9LUXhzMmpF?=
 =?utf-8?B?OTZ6ZkFrOG5VQW0wOVpaVnNvZjMrTlp2cEE0TjdxY1NqWWtRNUZub0FEd1ZN?=
 =?utf-8?B?N2FLelhNRkk4a21US3M3djcxb3c5ckZZM09JSHlweThvSlJTL1dWZ3RxSjl2?=
 =?utf-8?B?MkZid1VaOExZZk1CQ2FmeGJhYW1INVJ5TzVwWVFDTTFqVzZNQk93SHlCSndS?=
 =?utf-8?B?U055WitzWFBjN2E3TVB3RWt1cDhQRnJYOHRVZ3llQTdPZWxTNjJwcEFVcFNJ?=
 =?utf-8?B?dWkzdHRjQklsSkxXQUM5RFkzUzlISTFzTHl1cmR6aFo3U0dsUmR1RFlMTGxL?=
 =?utf-8?B?aU5JYUx0ZmFlOGJxR1RpdGt5NkMwQWZKdzNIQVlXQWtwRjlOUDk3Q1NwZERN?=
 =?utf-8?B?dEpvQTZVbUw3TXZoUFpUM2krS3IveFQyUko0NUkrWVFJNmc3czN4ZVllTlBl?=
 =?utf-8?B?Y0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9235.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bk5SSnZsaXNGVGRjWStaKzlBLzlORnZkdEdOWkZaOHZxM0FpMGlqdFd4TDBG?=
 =?utf-8?B?bjZERWN3TER4MVJYZGoxTlRiRWlwc20zNjcybjJ5QUtzblRFaE9vM091RWts?=
 =?utf-8?B?dmJLR3BENGIxQVhQL3pybkpzMzY1RmhvR3VYTTNqdXVWR1l6SnhLMEpLekpa?=
 =?utf-8?B?ejY2NVQ3N01sbmt6alNWcmNKMUhINS9GVDVGbWhIZzkrT0ZBRlZvTVpFaGRx?=
 =?utf-8?B?bDdtUWF6K3FpQWZRWmhxb3VtY3R0WThQT2hYQ3dHeWxFOXI0aFR1V3dnZUJh?=
 =?utf-8?B?K2gyNXFDemNwY0RvelB5cHBRUG4yUm1UTU4xOVRqNmY5czFMdmxsRWVpWHNQ?=
 =?utf-8?B?U2FnRWNkVk05enl4OVJoTWV2RC9Ga1VOa0g1MnUyUStMdG5BL1dBZitVdjZV?=
 =?utf-8?B?ZFdBcVM5QndNdnJyemJTNW9WQXp2YUEyL2dmck5NTGptMjJqLzBVRmxGblBr?=
 =?utf-8?B?Q0NPOWlmSGJqaWR3enFyV2s2YmNoS0lVSGtPeTJLUWdYemlXU21aYnhoVjJ3?=
 =?utf-8?B?OWRsZTJRbFJ4Qk9LUGMzVDNrcnlXVVlqSTMyOVZxZlpRUVBlQ2YwRjNkVkJ0?=
 =?utf-8?B?Vnh2aTF0SmFzcUtBOUJISHNkT2ZQVWdCT29mTEF3T1piakNsVzdTeG00OVJK?=
 =?utf-8?B?WjNqNnJpdURleTlldTJidktpOE96NDVYZmd1ZVlsaDBRUm9EU0ZXOSs2ZkhU?=
 =?utf-8?B?aklSN1k4R1U1dmdvbVVQS3g2RUZtZ3lWa0txd3pwclQvNkc0eUxKckJoUCs2?=
 =?utf-8?B?NVVja2ozTEpvN3ovWGkwSzk5ZFRjN0lDd3R4aFVzTUR4TGh2Tm0rejkwZkt1?=
 =?utf-8?B?Y1owampYdFRFbE5vMDBXNHFBekorTUl1dEtrcnVrb0NFM3VOSDFLcFBWRCth?=
 =?utf-8?B?V1FkaGN2YURPRy9iVnBFdlN1RW9NUFFyYmRMSkUyZk9iL2poYUh3ZkxMT0w1?=
 =?utf-8?B?ZHEzSmhMeCtuT2d0OXNxT2F6NWY4Mmh0azJnUFJhRTd0eTlWb00xVk5yWXJ6?=
 =?utf-8?B?RElLSUF5cnNLY1EzME8xV3VuNXJWRHU3TUV2a0hERXE4VDBpNUV2M1JKVDBM?=
 =?utf-8?B?cUVlWkFzbnIrdjIrUG9EZnBTekU0NzIzMnRYL0IzRVVNcVpQbk5SbEpxcjNT?=
 =?utf-8?B?cllZOUhyMUdhc2FJQlorYjk1UFJCN3AxaU53cWY3cnBybWQwdVRwNE4zN2lt?=
 =?utf-8?B?THdxcE1WL1M2WGkybDVKZWJ2dFdud05EcWFUcHR2OHdDQlNqdWFlT1k1T1dk?=
 =?utf-8?B?bHZJd3U4dTZmWVVkcncwTFVVaDlJV3U3QWxoUWs5YTNKM3pyM0pWMG9mRmxX?=
 =?utf-8?B?cUd6bnBLSDU2eC85dmJiV2JFemhYRFZwcXVRNXRFbUpwMHFjeXI3OG0zemVC?=
 =?utf-8?B?QTFxTi9YN2FNSXYyVVczdnhqbG0ycWF0UEJMQjNtcG10OU1HbW9kMW11OWdI?=
 =?utf-8?B?eEhRQzlHRjhTellMUzNkTWtvZTQzSi9ZWk5ta3RnM1h1RFdXc0pmajU4VURQ?=
 =?utf-8?B?R1ZDL3BlVE00YkJ0Y1JwaTltRkhZOWxnekJvcStEcXhJKzNsamVFL2NveG0v?=
 =?utf-8?B?cVJEN2xEQjJOMXY2ZGJpVlE4S1lqa3h6bGhyVHg0cEZBajc4SjFpREFqMndp?=
 =?utf-8?B?MVNYTUo0VEMzZVVIVWV6Ynd6T3ZhU0ZQZmZUNE52MGpZMWtoLzJodkNJL1RF?=
 =?utf-8?B?Ukh5MFJtbWRSY1FoQ2VCTGhmRXRDMDYxZ2Z4SjVIbGMyR1I4OU92Q0FuSC9r?=
 =?utf-8?B?ekxIdmRDdnJxK1BTMDNFVXVEYkI0MmNHcFg1SFNuSjNDK2NtaUlTc0lwZ0sx?=
 =?utf-8?B?WkthLzFSajBFV1U4SS9iY1BoWFpWaVV0S0JLMndyVVdIWHo1UkNaMXA1dURB?=
 =?utf-8?B?VTM1VDN1dWlDQXVzT3Z6bkQ2WngzRmtKRXJKSWVyb2RxdGY1STloYURBNEpS?=
 =?utf-8?B?QjVIVW4wTE1LQzNURmJGZGc3ODliMnplclZqYTZVQVphM01hbW5qL0VBZGJz?=
 =?utf-8?B?cU4zMzc1MThXTmM0UGU5YWY0RU1hWEtJb0REN3ZWeVNSYmRUV1YvaTBEOHR0?=
 =?utf-8?B?NHRObHBkaXorSVJwWURmL2hpR3IzMTFnc29JV1RVTWlNZ1czenl2QUhjRHlM?=
 =?utf-8?B?TUk2eU1UbDRUYXR2TTZVc1VEcWpOb0xRdGtTMkNWWnFYZzdyeVduOEJJaGdF?=
 =?utf-8?B?RzJQRmFQdElTbnVDdEpKK0NYaVJzdzUyblI5My85Snl3N3hEWTROSEVNUkJM?=
 =?utf-8?B?dlhXeGtvaWZTVTYzRU0zYnhLYkY4QUlyaWd5YlVmWFRwU3FGZE9qclhURWRl?=
 =?utf-8?Q?tMYmaQVvx7ekUAqcVM?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 91cb5a91-2046-46f8-1a84-08de67d06bfe
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9235.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 11:43:19.6852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0qPbLXc/GRIrCQjT8VnA9txChJ68kngg7eQ4vXcNnocTaTeRyR6+bstK5VqHr0t/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB8458
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[axentia.se,none];
	R_DKIM_ALLOW(-0.20)[axentia.se:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6521-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[solid-run.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,axentia.se:mid,axentia.se:dkim]
X-Rspamd-Queue-Id: 22CF010F523
X-Rspamd-Action: no action

Hi!

2026-02-09 at 12:31, Josua Mayer wrote:
> Hi Peter,
> 
> On 09/02/2026 13:10, Peter Rosin wrote:
>> Hi!
>>
>> 2026-02-08 at 16:38, Josua Mayer wrote:
>>> Add prompt and help text for CONFIG_MULTIPLEXER to allow enabling this
>>> option thorugh the kernel configuration without explicit "select" driver
>>> dependencies.
>>>
>>> Select it by default when COMPILE_TEST is set for better coverage.
>>>
>>> Signed-off-by: Josua Mayer <josua@solid-run.com>
>>> ---
>>>   drivers/mux/Kconfig | 9 ++++++++-
>>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
>>> index c68132e38138..4f7c6bb86fc6 100644
>>> --- a/drivers/mux/Kconfig
>>> +++ b/drivers/mux/Kconfig
>>> @@ -4,7 +4,14 @@
>>>   #
>>>   
>>>   config MULTIPLEXER
>>> -	tristate
>>> +	tristate "Generic Multiplexer Support"
>>> +	default m if COMPILE_TEST
>>> +	help
>>> +	  This framework is designed to abstract multiplexer handling for
>>> +	  devices via various GPIO-, MMIO/Regmap or specific multiplexer
>>> +	  controller chips.
>>> +
>>> +	  If unsure, say no.
>>>   
>>>   menu "Multiplexer drivers"
>>>   	depends on MULTIPLEXER
>>>
>> I'm not comfortable with making MULTIPLEXER a visible symbol. It is meant to
>> be selected when needed (and there are a dozen or so instances). The kbuild
>> docs has this on the subject:
>>
>> 	"In general use select only for non-visible symbols (no prompts
>> 	 anywhere) and for symbols with no dependencies."
> The patch description didn't make the decision logic clear,
> and I plan to submit a standalone patch for this after v7.0-rc1.
> 
> Basically existing drivers using mux core used "select" to enable it,
> even though the core can function standalone with device-tree.
> 
> Some of these users (phy-can-transceiver) function perfectly
> perfectly fine without mux, and use it as an optional feature.
> 
> Likely drivers only used "select" to avoid writing helper functions,
> prompt, kconfig description and stubs - which this patch-set added.
> 
> So I will argue that some existing users relying on "select" was wrong,
> and that the mux framework is generally useful on its own.

When I wrote the mux sub-system it was very much intentional and by
design that drivers needing a mux should select MULTIPLEXER, and that
MULTIPLEXER should not be a visible symbol.

You say that it could be useful to have it visible, which is all fine
I suppose. But, you fail to address that quote from the kbuild docs.
Why is it OK to have the preexisting drivers select a visible symbol,
when the kbuild documentation states that it should not be done that
way?

Cheers,
Peter

