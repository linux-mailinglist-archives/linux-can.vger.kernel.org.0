Return-Path: <linux-can+bounces-4401-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5E1B3D71C
	for <lists+linux-can@lfdr.de>; Mon,  1 Sep 2025 05:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E66C817460F
	for <lists+linux-can@lfdr.de>; Mon,  1 Sep 2025 03:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510EB20C461;
	Mon,  1 Sep 2025 03:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Kn7xJql2"
X-Original-To: linux-can@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011036.outbound.protection.outlook.com [52.101.70.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37A941C72;
	Mon,  1 Sep 2025 03:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756696721; cv=fail; b=W1DLNxyIzGm0nhgem8MIBM5ZrGvxkytoouwJCbQy21b+lD4B42ObCiUJiiXYFfijiuRwvZ+Scsz/tuyeDkOX/QQZmYoXSDgx5BWX57vo/QiUiBtRDQ0DOW4xNKaZFSy3ofV8bG270uRNG74KywTKAkWPUB7t7tBlfwOLpXYSll4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756696721; c=relaxed/simple;
	bh=qgIzkz/p6v34KOMJwIuxEUo4BHaDE2kNjMWqpNY/NzI=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=ePSedfA6Fx8ko2IfC5pxOlrgeTH21sySa7bNrZVNT/c0d8Fiesyo2cmMWoPTSVzHxbgEVAwtFClZPQqWh+lXox9XajGHdUAY9OJuFOvrTFg+vke8iVZSpqLzK4BwISs2cY72xIlNrF+GHw0h3gYZri7KkuYqejfOeqqOlb6hZyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Kn7xJql2; arc=fail smtp.client-ip=52.101.70.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qi1Yjrc8AiM74379oDmW+m4UKzBu8/Iz2H1AzNDcNcxrqdKHo42ul95qRKQ8WmYI4RgWWxLmuKuAZGvM2MtKRWz2dFlgq4oJszq+0/1H/DmerrECSdG1tzgVArRo1iBuEdjwIxF4OoRvwRMr8pjFX95RYAHKqbz5fduykC0SUEdqNu+IfclyhggnlebUk8z8TkTTnUY1m1UsOIhEbj9ouwd73CJd92NnVh7neIRZt5rOoIgjyUTug6Q1fidk7z/kGi63NKhibjn8zckMF+tV4l5xq3wJP3fP6qqyqHTyPxvSgiMNP6E/l78jvyiy712Cg5yZLujj7tHtDDMV26Ru8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGk91iDmcshkrkW3NiSnZpqr1/3dWFyFODlpFobI0CE=;
 b=hBK1j6cIsJa5AJVyy4H3rhVG7NcBGHrIVRIF6zW/sYwo65wHZ2ilF6rxt5QEhw6XIA7fb+wAJpaiX5LQawoj6xC2VK/tkCBYXjetoKTwTI7jcFGjVDSSdXUYjh+HQmob8E4KtVba72mEU++p0+GHeDiZnzuM2rtx2XGuTJ+K6EliEGPo/aVjP0H/X8XUMh+VDxXnn6itEtlaS28gJ4YVtGzuv/++48HV9ENsy7BCf4S8a4woiUClCB3WVzm1eq0JJu7F0YokZFvw8R2Rr9Y/fOYXrFmfROshZT0Gzqg2CbC1jPdfwjVCTNtzYUXmf7hJcXtOsgoUCTuE9sFn8byJlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGk91iDmcshkrkW3NiSnZpqr1/3dWFyFODlpFobI0CE=;
 b=Kn7xJql2qGZ19K1WHKqdZ2+MYU4tYdABJOG7gXVIC/bmNFKKPu0YUk1EwdDfOItL+mBoLc1D8RaWXHv/sdCieJcfdAgtsdt4UoXxCLUkNeXH2USyaHMjPkNO5A6EyBewYuj/jLEangZhG7FRUr/H57qkYMbP1TbnkasROcHYjE1pCSr+5QXMte0lwJizA06I1cP6jSx7UI73oL5LVegHHXrfFeqUNPUdso3KYKg4MvB0RxQr02O6Yw1YvNg89KcJSGIjOMFH8m27j7C+A+jnvQnO7rHVx5v0jTHEhTladWJ5dWqxJwEpanNyY6IXU16dsWeqKn6U8OA9MzKYjk82TA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10321.eurprd04.prod.outlook.com (2603:10a6:102:44f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Mon, 1 Sep
 2025 03:18:36 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.015; Mon, 1 Sep 2025
 03:18:36 +0000
From: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v4 0/6] phy: phy-can-transceiver: Support TJA1048/TJA1051
Date: Mon, 01 Sep 2025 11:18:10 +0800
Message-Id: <20250901-can-v4-0-e42b5fe2cf9e@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHIQtWgC/1WNQQ6DIBBFr2JYlwYGqNJV79F0ASNUFkWjjbEx3
 r2oTdXln7z3ZiSda4PryDUbSev60IU6piFPGcHKxKejoUybAAPFCuAUTaRYCEArPRMgSCKb1vk
 wLJX7I+0qdO+6/SzRns/Xo99zyqiVyhjOFealvcWhOWP9mmM/EjYSWa58zsCUzvzJ+U8P+7ZaD
 ZgNeeFOe7TI5dEQe0OvhkiGsOCFZFp6pTdjmqYvq5O6eiIBAAA=
X-Change-ID: 20250821-can-c832cb4f0323
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Aswath Govindraju <a-govindraju@ti.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>, 
 Haibo Chen <haibo.chen@nxp.com>
Cc: linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Peng Fan <peng.fan@nxp.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756696708; l=2276;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=qgIzkz/p6v34KOMJwIuxEUo4BHaDE2kNjMWqpNY/NzI=;
 b=nKDMjo/ns+E/sxTyVJcL2/rsrGh9pt90wZKx8Y9adLeDYf+xcJTDkwL0JRsjHie4FrJcgVgAH
 LBFifImlH5tD4qWbcvKVE3BEvEIRPgnbyL6J36UqLUH3ii8guwQWnjX
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG3P274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::24)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA1PR04MB10321:EE_
X-MS-Office365-Filtering-Correlation-Id: b2cdb174-0bee-4758-4d41-08dde9063d01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NnFKeUdTTmJFb0NjeVRRbGFnNkRJZFE1ZzJHZzdGM1dGZnJ5bmxNZy8ydXdq?=
 =?utf-8?B?MVpuemQ1TTdlMUtCa010bFo0WmJEM2J6UC84SEJUZm1Xby80WHArdWlJcW9o?=
 =?utf-8?B?TkRQT1NKT1lIUXVBWnJGdlYzNGxncjVCbjFVWndNRHZLRW1qVk5rOEFZd3Ay?=
 =?utf-8?B?U3dFYXQ2Tjk5ZXlIN2V4YzZxalFTN1hDR0FwTStYL1A3RjNsNFlFK1hVRDVR?=
 =?utf-8?B?SDh5Skt3dlhKTWJuL00yTXhkWmpqVExLc0ZPS1pDVkY0bDd0TExaa0JlWmdQ?=
 =?utf-8?B?U0YrU3ZuUTVKVVBSRmZTZzJpTVlKU2sxcElHRTcvNnFjVm5adFA3ajJyRXMr?=
 =?utf-8?B?Um1sRERxbE1OUlJISVNKb3N2UGtBVHRKb1FlaGYyRnM4QWIwR0NObWg3ejA1?=
 =?utf-8?B?MkJ5TzBtQ3paYU5FbUdxdUwvOHR3bGVHMHRPVGxGTjhXTi9PQkVkUndrVjJm?=
 =?utf-8?B?NHNPNUEyWVhxWG9veklVeWJUOVAyMzZNU1AxL2RkcXpjdjQ2ODgrSDgzcTZ1?=
 =?utf-8?B?TGxVMGZOQTFVWmg2VkdNNlZOZGJVQmJPT2FWakdGMEFnNU44K2ZIUVBCTWsr?=
 =?utf-8?B?blFkLytJaUFzYjhET3VtVSs4STJzWVNmY1NPY2J5STB2c3lqM0g5U3dwNU9t?=
 =?utf-8?B?YVJPWUdkSVpONkpxS1J1d2F6NnZUNThMelAyWmpiM2h1UVZyRGxOZmxyNmZy?=
 =?utf-8?B?azNhbGY0R3dMRGNmQjhFOU55QTBGai9HNXlRcXB0dktSOTVkUW9uSHdIR1Z3?=
 =?utf-8?B?ek4wVDZ1NmdMaUJJSHU4YThFQmplWDVxbWVRWXJhR2RKbFNMK0lKUWc1NjVE?=
 =?utf-8?B?cTU3algxSDJ5enVFR2ZLcHRMT3dVTkRSZTBHNHphU2FGNkdtTEFIVzNtcmRr?=
 =?utf-8?B?MlZHTzZ3dFhtcC8yakh4M0QyYzlLWTJZM1lCTUxZbjIvcnRmWnIyKy9oZTdV?=
 =?utf-8?B?OUlMNjBTSDZONmxkclR4NitmeitqNUROdTJRY0xISkZjMEUwTXNvK3gxTVBt?=
 =?utf-8?B?K1ZKSHFVU3J4RjlSWDZqZzc2cU1vN1RWcyt0NzQ0cmZjQXFBVGpUTmNFekt0?=
 =?utf-8?B?cmdQOWVHNVdNTFF5ZW9GOW1wWXdYSXBVaTRTdmNqZHg1SXZ3KzZSbElUd1BD?=
 =?utf-8?B?eHZyVzkzMDR6bm9jRjRnQmhXZ0U0aTNtRWdDV2xSczhQTjM2OGZaQzE5K2lm?=
 =?utf-8?B?QllZcWFMMjQvc2VQSlNjSVV2QjBxM1AwOWRVTE52ejBzTTVka3F0MU95ZGtu?=
 =?utf-8?B?WVVOdVZmRFNvNmhGazNNbHJ0aWJuOUp2S28zSjkzYUZhSlR2MWZTUnJINUM3?=
 =?utf-8?B?OEF5aXFlQXRielR4eHhEWDV0SXlOVWUxU25jS0lob0VoK3ZVRU4vSHgvNDg1?=
 =?utf-8?B?dHVLWEw4UkFSVm5UemVJUFE2SDhJdGw1RjdoQ243RXR0TGh4bm44aUNFUG5I?=
 =?utf-8?B?dzd5R0pvbUcwY1pQQmc3UjB6aEpiM20zVDB4clh5T2QvT3JvWGZRTDhvbTE5?=
 =?utf-8?B?Qlo0TFZMMmI0aTlOSm5YeTJJRUs0a1BJYm93cnlkSjlaU0tJQVAvYzFDeVIw?=
 =?utf-8?B?TVkvQkl4Ymo1YUUyRXlJUnJHRzArbndBN2kxQ3RrZ0REbG1mM2VyOGxPTlEx?=
 =?utf-8?B?YVJvak43MDkwRXVXZzVZL28xQTIxd28rZ3FQeURFQmFPQi85eGd1ci9SMFEx?=
 =?utf-8?B?N1BRRC9WL2FhV3JMQW9QckJneFBnQjUwcDA5Qjd2TU14T29CM3J1dzhMbzd4?=
 =?utf-8?B?VjNiWTFRMExxN28rZUJCUDM3Z2dsNXl2eVJkSkNTZjJiRkl3OUVnbjNpeUdx?=
 =?utf-8?B?cThVNWxDWUdCOFVBMGtudzN1Z1c5T0l3Q0l1em13dmFnQjVuU2tMbzZXQ0lK?=
 =?utf-8?B?ZVoxQ0dMczdNQzBrSms2d1AvRlZyREJsUlkzT3FOazErZFlXSG45V0NXZ3pp?=
 =?utf-8?B?WEV1aHhnenFva0dPeFFhL2tYaWlLL01qNyt2U3dNNk4yYW1wRExMMmhOYk5s?=
 =?utf-8?B?Snl4S0g1L2JHM2h3dXI0clJyQTRGZ1U1VGk1aHpWS2RIWnRtSm1QQWhzL29Z?=
 =?utf-8?Q?Ud6Ww/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rk1ncDRNbWFmbmVIWmRlczk5SGJ1YWRUY0MyVEkyNjhTS0JUUjVHMjE3U2pV?=
 =?utf-8?B?TlFEQlRYck56dHZ4OEYvMkNZSGRMUkI3M3lWT3kvd3J6ZWRrQUh1b3VQUkVU?=
 =?utf-8?B?dzg1UjhKVUV5UG5FRGEvbWtjSGU0RVRxNS9JL1pLdkRvZG83TlBrMEs5OGRX?=
 =?utf-8?B?Um04ZUNWZ0ZHTEhHUVY4YTRQNXpiUHJuZDJHaTRVdzR1UXgxUG5rblR4ZjhK?=
 =?utf-8?B?UFo3N08zcDBsdGJJWk9aYXQzN0xubEJXbFRuOFBBSGVWMkI5T3NtU2FEd202?=
 =?utf-8?B?bytHNFNNeG1IcUFoTUFqMGdUWTZ6T1lMQmUyWnFFSjZsZTdVbXovVUtVNWRm?=
 =?utf-8?B?SXFJam5tTWxSMEZDdlA4bkdIZHI1a1hmYlBOdmRaQzY5NjdGOTQ0cWhWQWdr?=
 =?utf-8?B?aHRHUTBZalhtamtjVUlBZ0FLQXRDQ2l0NXdJbDFMcHRHTFJTZU5ONnJoZ3Qz?=
 =?utf-8?B?akp6cXVyRTVQdDV5cVViaWloUis1STFFMWpyTEdmUEQrSVpOOGp1aHVyK0Js?=
 =?utf-8?B?bUQzWEVwWko2eUNPWFFMYTZlc3VlRlJXWU9hdFgxbzZZM0FEMW1EamhZQkJE?=
 =?utf-8?B?b1dUeWd2VWpDdHR6Y2Npay91YUJZdUpXdmNXczdEUUNYYWY3aUZDR1hVR2g1?=
 =?utf-8?B?QXc4L2JMVk1IN3g4UUhnYW03NlRvdm1HbWlFVUs5c1pMYlJzU1ZoUU0xT21D?=
 =?utf-8?B?blk2WVJFWGpRb2liMWF3Q0djQnowWTZsa2lTU1J3S3ZUL3lhZ2tsYWVVbjRY?=
 =?utf-8?B?UGtZLy91Mi9Kc0NJN0ZRTEdjZnZTdDFLRkpiaGZJQkc2dStOQXhWOFdCaE4v?=
 =?utf-8?B?dzBiU2VZZmRLb3NRak9XZkoxN1ZaMTA3dFhGcUNWSFNIRDV4MGRrS09kZ1B0?=
 =?utf-8?B?YXNKSGNsUWFyMDErb3VxQ1lpMytqUjRDUzFVY1FqeGdsdDlBNU9nTGNGSnJS?=
 =?utf-8?B?Z0ptSG40dG96N0ZjSmZ3OE12THhzVkVjbHg4a1NGYk5ROE9xOXpVeWZ6OW5V?=
 =?utf-8?B?cTM4eVVKZllsck9BSWJneTFhc2pZSWxlVzgwZ3duaG9VQlY4NDMvbjduWnNF?=
 =?utf-8?B?d21PSnEyZyt3M0RCaHp1NDF5TGRrZ2drREJVUVVFY2JwSFNlS1Qxamh1UzFF?=
 =?utf-8?B?NG5VVDUzaHYrZGJaNEM3Q1dnVnVySDVnb202MWl1aHJBNUFZaGcvdlFaMDRH?=
 =?utf-8?B?bVZDakE0eDRlM2NDa0t0TmdEK0NNeXJHY0dhMFY1bzJ2S2J1SFJvVDhCZURM?=
 =?utf-8?B?WlNobWpQdVZISVpVYTRwcmlhV2JZcFQwMGRnQWhNczBaUkhCTXd4ajhVcnE0?=
 =?utf-8?B?b3lSaFhJZ1h6RFVnUmlJbTlJUjA4ZVZjRFNGTmlsU3ZCQUlkZzc3a3NTK3h6?=
 =?utf-8?B?dUdvRVhrZUpqVjBsOHpCcm5iYThJYjcvRldBY2pLZW90NHY3ZDJGZjI4ZDc3?=
 =?utf-8?B?M1ZYdmcwSVo5Mk44L0p5THdSMjBKajdRWC9TcmhzT2o2V0kvN2pxQmdTZGZU?=
 =?utf-8?B?cjFMNXJaTzJ3RlY5WFk4bUZXN211K2dYQmZQTVI5MDZnazBkVW5zc0lWeGp4?=
 =?utf-8?B?U1VOYllOaHhYVXI4Y2phWWZHWDJQMU4rN1VEbGdmbW9ucjcvS1o5elc4L2Zl?=
 =?utf-8?B?eWdBa0lGSHRXKzRYUnJ0ZjFYc0MxcXJOQit4SllpUERDeXE5bUYzWXZGZUk1?=
 =?utf-8?B?Y1p3emVTbW5qenlNYk1jdi9ocmR6S1dnUGU2WTVyV01wb3FXVmVGZ2hXTUMx?=
 =?utf-8?B?dngxdDFTdEN0NVhPVHZPMFJwTHRUaitzVWRwVGY4bGdxbStJaVdmQW5lWUFM?=
 =?utf-8?B?WnROQkRlbHgybVRHNHoyOVJLYTBBNWJXVTdRWHlob2dLU0JnOUxyR1B5UGtr?=
 =?utf-8?B?UnlqWHRKS1plM2pUaVhIS0s2bTM0R0ZNOUtuL3NFMVR6a1ZVUk1sSEFKT1BG?=
 =?utf-8?B?emd4b0tEZ1JPajdMUCtMM2l1OVpqVklac1RvbHJpR3ZxajMyd0dnMHpad1li?=
 =?utf-8?B?ejZzZklXSzFZN1M0M2JGb3luL1dMNkprMm1OSHpqb05FUXEvYW9GMGhva08v?=
 =?utf-8?B?dVp4VXFKNHllZWZweG8rbVlHb3lIMmQzN250WGNHWjNVQ3ZBSEtCTXFJUUU1?=
 =?utf-8?Q?SPBzhpANpgS/6Cky/n4f58ITe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2cdb174-0bee-4758-4d41-08dde9063d01
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 03:18:36.0654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cxJg8K72WsF4pzjUYx4LxEVmNdnU5ylQDSO9tQfY/hqJkC26/rCGlyqXC5qH2HuD5kOhjkLYJzGuqFXWBwbQsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10321

TJA1048 is a Dual channel can transceiver with Sleep mode supported.
TJA1051 is a Single Channel can transceiver with Sleep mode supported.

To support them:
patch 1: add binding doc
patch 2/3: To support dual channel,
   - Introduce new flag CAN_TRANSCEIVER_DUAL_CH to indicate the phy
     has two channels.
   - Introduce can_transceiver_priv as a higher level encapsulation for
     phy, mux_state, num_ch.
   - Alloc a phy for each channel
patch 4,5,6: Update dts to use phys

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v4:
- Add R-b from Frank for patch 1, 2, 3, 6
- Address the minor comments from Frank regarding min/maxItems, commit
  log
- Link to v3: https://lore.kernel.org/r/20250829-can-v3-0-3b2f34094f59@nxp.com

Changes in v3:
- Patch 1: Add TJA1057, update #phy-cells
- Patch 2,3: Separate patch 2 into two patches per Frank, 1st introduce
  can_transceiver_priv, 2nd support dual chan by adding num_ch
- Patch 6: Change to 5Mbps rate
- Patch 4,5: Add R-b from Frank
- Link to v2: https://lore.kernel.org/r/20250825-can-v2-0-c461e9fcbc14@nxp.com

Changes in v2:
- Update standby-gpios constraints per Conor's comments
- Drop patch 2 which is not needed.
- Link to v1: https://lore.kernel.org/r/20250822-can-v1-0-c075f702adea@nxp.com

---
Peng Fan (6):
      dt-bindings: phy: ti,tcan104x-can: Document NXP TJA105X/1048
      phy: phy-can-transceiver: Introduce can_transceiver_priv
      phy: phy-can-transceiver: Add dual channel support for TJA1048
      arm64: dts: imx95-15x15-evk: Use phys to replace xceiver-supply
      arm64: dts: imx8mp-evk: Use phys to replace xceiver-supply
      arm64: dts: imx93-11x11-evk: Use phys to replace xceiver-supply

 .../devicetree/bindings/phy/ti,tcan104x-can.yaml   |  30 +++++-
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts       |  43 +++-----
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts  |  17 ++-
 arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts  |  13 ++-
 drivers/phy/phy-can-transceiver.c                  | 120 +++++++++++++++------
 5 files changed, 141 insertions(+), 82 deletions(-)
---
base-commit: 6aea185bfe693f3b373488217c198d2c3daed6eb
change-id: 20250821-can-c832cb4f0323

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


