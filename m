Return-Path: <linux-can+bounces-4531-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6272B4A146
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 07:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 250557A86EA
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 05:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2392ECE91;
	Tue,  9 Sep 2025 05:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HLodo2kh"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011024.outbound.protection.outlook.com [52.101.65.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B56335C7;
	Tue,  9 Sep 2025 05:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757396438; cv=fail; b=bjyEhXOtHaLJDdx30iiWxyEtTpc+KNP6t2h6UQfaYux1rPflYBuijQPDHrImDWrb84LtUo1VWXLt4RZp6QkD5qgXGtaPSrKmSRnDjc7+rVAHdSXyIgA12EmimnHJemIpKJIQnILDqHcuI9nAs2k21la2TU6Eh+ajmAqvirQE3WA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757396438; c=relaxed/simple;
	bh=27J+78C1FSp4cyMCTiFvZXaRJG8mOC7ktuWzzCk/jJc=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=EhY37BYThMqidyu31KQgbDAynmfPL0D4XjG4Ofmv+5L8p8lN2M66hTjOld8bdKOEbvbuECU0+EFF5t1rTI2Y84H5utIrCJKYwHT5rIUOFb/z8qSWOrQ2PVkc0gqWBg7zvnj0Y0m5RuRmgu2ddNXYp6V7xeG3A31gfZsluTd27Pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HLodo2kh; arc=fail smtp.client-ip=52.101.65.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VzprKjGnkJ5areFMcjxzpxM0Yz21TslU92uJsQts+ez1J7sHHm8I/oFWbNuHAv0BIZn3tSgRrCTImkzrFpJkYUmub50N84iJVNLxJCjAhQCVAqJvza4XXhma5tF9fOGm/NG5miu3G6/+VZksMlpAX1xKDMssvspbAFyTi1/BIlXtrrjbtuP2n2C2yNeXBe8gppESrEnN/2aXMKYCELjR3t1Pw8oUAE9a7wREugjNpVR5W61J/MfpETxCBKYD5mqpBd6UAF2QL/6sYDAmRH78sfgrlQmFNbX5QtFV/j2/uAo6CDwhqbESI0lpEAAEVzCZuheCHn8NfKPYV6ydnm0N0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDxS72R5t2ZXfJCF9aAP9XnydL0Ni+PBM3PsUoSXvY0=;
 b=JLLi9UlojEQ2YdKD3LIs+4nFFamd1t+6eZcfU43a+qK4a840nQqr24YZIbnaXz3BWrYvq5FD7JBPSvphH8kVf1+4w5A7YyU+oxEr7I8ugSV6u8US3xFHXzpK4JgPTilZj4OjjJr0ZDpKlOpyjNsrro+52zvnJe0ukOP8O8uawKiJX4fx3kTttF5xlmiHN1EHVH9UI168arVqiv2+TYa0YBDa7HgvtGzMLcKYbCL8H00bWuZX6dCl4kcAnYI1diHNuw/Mdl1dTD95V4mRosaUCRK4PHahPqPx5HBcESLfK/SGX4hFOAgkLIH77UhjQOvqXztOnHKvOt/bjuCmChV92Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDxS72R5t2ZXfJCF9aAP9XnydL0Ni+PBM3PsUoSXvY0=;
 b=HLodo2kh0ICEz2hb5z7GiaMUKnoVgxXzwCpxbGZybZNLeZH8u76kkZYO42/CP57UpSBcL8v0/WnkrbkzuFK+LW40/YSwoDTqOvN8gHcbmJ0LQVWLAnpKjoEETU/LlX+tdwvoIYGKauNVw6tUF/n8GkuAeqLPOOlcWn9yuns2YyRE/5PrMeJO2qc6s424G+LlPbKAkZLezhkE/fuoWxNoAxmWD18N6kuJqx5zEWRNlY13mR8pk9BiAMD2a2XrwmsHSdBYNH+iLQ9iQpENQfnKgNDStP/sBm7vqKBohWKvqAA8zPHDTlUVuF4zNd+6GqzOxvcTaJz41KXpoVZ5p3B3gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AMDPR04MB11583.eurprd04.prod.outlook.com (2603:10a6:20b:718::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.14; Tue, 9 Sep
 2025 05:40:33 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9115.010; Tue, 9 Sep 2025
 05:40:32 +0000
From: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v6 0/9] phy: phy-can-transceiver: Support TJA1048/TJA1051
Date: Tue, 09 Sep 2025 13:40:10 +0800
Message-Id: <20250909-can-v6-0-1cc30715224c@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALu9v2gC/23PS26DMBQF0K1EHpfKfp+AM+o+og78eW48KERQo
 UQRe68JUQGpw2vdc20/1CB9lkGdDg/Vy5iH3LUlHN8OKlxc+yVVjiUr0MC6AVMF11ahQQiekkZ
 AVZrXXlK+PVfOnyVf8vDT9ffn6Gjm070fTaUrT+ycMRzq6D/a2/U9dN/z2KsJazPomlOtwUVxf
 835nhG227wImAUdjdgUfDC0F7gVdhFYBHpISNpSYrsXtAqrX++nIoTAcxIIycpe8FbgIriImLg
 GQQfmnx9bTWsTMDYGrGfhuG5P0/QLNS0cZLABAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757396425; l=3351;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=27J+78C1FSp4cyMCTiFvZXaRJG8mOC7ktuWzzCk/jJc=;
 b=4k0YF7sZoKjF74IRNrERccLaI7Pviy6ssbIRDqQn06mz1JLoPbecisYV4rTFZt5gxlDzJ2HOR
 dUozlLGK35kAr1dgxAxV+WQ0p8XCMr8b6xNk+mm2eeYtUxVh8jRb7wc
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::11) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AMDPR04MB11583:EE_
X-MS-Office365-Filtering-Correlation-Id: fe43df29-0cab-4c54-71de-08ddef63649e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Sy9nbFRtMFhQQ0grMGowSFlIQWgxUlFZeDI1Qm16SjNQajN0cGdOaXYrdmlk?=
 =?utf-8?B?bW9nT003c1J2MzJ1YmlXWi9uOE16Qm45eFF2MVkwU2FEN0xuc1JsWDBqOXpD?=
 =?utf-8?B?VlBIOFBrYm5TQWFiQzloeWxzZ0xWdEJhYkRCT3pxL1VVZWhJSDB3YjhjUU43?=
 =?utf-8?B?Q2Nod1g3eXRGQXNaR2FHUzh6S2pGNElrYVVJZjB0UzJ2MFUxWGJiQ2MrbzIr?=
 =?utf-8?B?ZFNrWjk4ZGx2V2xsM3hiVUNrOU9Mc1lIZ2JhSG1ldUlkNWt2QlI0SnBGaVh6?=
 =?utf-8?B?a1REZ1lXcnZkRlhXWkhyd1NwdGdWeXZaaFlKUG8zZ0s3N0wyRW1IbWJuY3dE?=
 =?utf-8?B?YVZtYzhGdDkyV01RY0twckRVYWhhb3FMVjdKT29CekJDYlZEVjdWYVJXWE95?=
 =?utf-8?B?VHllcVVtSmVMREtYZXdRVGZCb0Q4TFZhc1kyRTUxU2pZK2VxOUJweFpwR3gv?=
 =?utf-8?B?Q2JCSFNWeDJjZHVrNmZWTVlzZWFFQnFWVlQzb1Fyb3lkUjZJdTBqSlAwTUlv?=
 =?utf-8?B?VERTdkhqN2VrL3dmcmhqT292WVdDMHFaTzhJOEhkQUxGWjFZbTZJZTV2YWJP?=
 =?utf-8?B?Q0kxRmYvZnNFdEFidndTUWIzdUxrTnNrNmpVVTAwMURsUmplTWE1TVVhOU93?=
 =?utf-8?B?dGNoYTdHTGhYZllMck1ieGlrdmxpczgyM1laTERUeG9JOEZodHp5eWJSNjhm?=
 =?utf-8?B?a0kydkVvMGpLaCtKcndudU1qNTFQaHZNME5XN252bUVTVkx4VzJhOTdxQTR6?=
 =?utf-8?B?bXd4akc0dWFzMFFmSVQ0ejJyaXUvNnlrTE9kd2diNGtIWVlaTHFkM0J0VCs5?=
 =?utf-8?B?RE9HOEZ4RmlKSkpCamRIZDI3VUphdnVZenZVN0FVYnJOQWU3dHh2alhQY2ZU?=
 =?utf-8?B?N0lJMkhmNy9MNmZ4VjdncnlBUi92V3BIQmtla0ZWRFlUd05TTDg1Q2FrZm5J?=
 =?utf-8?B?YjljMUJtZEhJcTdVaWFBSmJhdU95NjJudjE1YmpTSW8zT2x1aTJuMTBMejZY?=
 =?utf-8?B?Ly9EQnJhdVdpS1I0aHgvYmJTdk8yYVlXdnNVM1ZibHI5RitwWlMycDhzUElp?=
 =?utf-8?B?ejlTQStpVUZrZUZGVWI3SHliM1ZveWxONzhFQlpwUHovU0YzcW9SYVdES3lo?=
 =?utf-8?B?LzlFTzFVT0VLNWk2TGdzbHY4YzZRTy9NNVBNVnFpck9NZnpubFpWYlVwVTVZ?=
 =?utf-8?B?Z2t2R2crQ2JsenF5ZFVTMnRaRHhzNlNnSXNyalpzOGRNU0dJNktkVEcwU1VU?=
 =?utf-8?B?RnZFTjV3SjJsNkJWbVg0OTlKcXh1cTl1U2lNNjVTY3pQdmZYR2RWMUYxSzNU?=
 =?utf-8?B?bkpjdWpwVEJqQVorM1pveEJURDBDQlk1YXZPZklVOGpNd1FMVmlLV3IxQzRs?=
 =?utf-8?B?NUhvWHRnSlZ2UFhHQWdWTUJCdHFxd3ZoK1BDTnJkRUFIeHdwcXd2N3N2VktY?=
 =?utf-8?B?M3NYY0V1cHFHdnNvV2tITm51bTlPdTRJVFV5UUJFZ3Bvcnc3UDVnVkxiNzZ4?=
 =?utf-8?B?SHgyWm5RZXBUcGpWVHA5Wklickp5NE5rT1Mwb1d2R1gxbnVRb2dSamR3UGZk?=
 =?utf-8?B?MlRZNFMrZlpTT0c3Zy93RTVnazI3SWFaanlTYzQvM1FJZW1ydkQxbytiOTlJ?=
 =?utf-8?B?aUJYdzdaSU5DQUxWNzArRUZMM2VDakpYVlRjbXB0eUZxWWw1WFNVVk54bGE1?=
 =?utf-8?B?NEMza045OE1TMkRpaWRoQlowUkxaaFF6TGhoZ3NFcWQya29MRkprRlRPQ2Ur?=
 =?utf-8?B?Y25VV3JNa0FQTW9PVXdUNkVrQW5VRzdnTS8rOG5URVBCM3hLb3d0SVZTTDlY?=
 =?utf-8?B?MytxTG5CZDZpWjdMY1lKYi9kenJINUUvL0xRYXN1MG1VMVE5c2VKRXh4ZTk5?=
 =?utf-8?B?cXNtSnJxalRmdHMvbEViWDc5Z3dzQlFmV0J0a0ZqRFJ2UkVEL0tVMEZPRzA0?=
 =?utf-8?B?MG1aS1NCMHNQaXlDdEx1ZHduNHI4VWhQb1ptME1HU3VWcWpnaXVoMkJ3SnYr?=
 =?utf-8?B?WFV4RjNzL2NwbEw5SzFQWE1CVnNHTmQ2LzFPZ2VCWjIzQmMrdlBIbE5za3Vm?=
 =?utf-8?Q?kFeOXE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmJWaDBSY0dtaXU2QUJNYzZLVHBCR2Nib244Q3pseTB6K0xoTWdjNDIzQmRx?=
 =?utf-8?B?WVpzL3psZXhsWVlmTXlWbzZQYzk4YnpISFVyVmVVS0RIOXJaUFVNdXZBQ0gv?=
 =?utf-8?B?bkc4S0wrQlJPRks0aXF4NDdaaXhBeVpnMUd5SUhrb3ZwTE4zbzcrWEtyK1JG?=
 =?utf-8?B?TXNVQUVnL1k0NjBLbXlEZDdlRVdTUlloN0xUR2RqMzk2UXgxZDY1dDhwcVZL?=
 =?utf-8?B?eHZrOXZIcFZZRHowa1VpSGMzWldXQWlhUmt6cDFtaVVPaGQvcDFmSm5ya1ZY?=
 =?utf-8?B?WW54WC9USDdIKy96dHBwTFRzWEZNYnpWQzlydmJSSkw4RkV4OW00SW9LTnVK?=
 =?utf-8?B?dTFscjAycER6NVVoQlBlYlFKYmYvVnl5a2tLNGZVckw0VnBXeVAyUS9sN0RV?=
 =?utf-8?B?UWtnRnZaaWk5TWVtN0JRUG9IdVNzalBIaktjdDZrTENNcUVBREcvOHFjamU1?=
 =?utf-8?B?bmVZR1FRc0FoU251c2Ixa0RaN1l6NldGN3BXMkMvVkZ0dGlKeG5Za3NTSEs3?=
 =?utf-8?B?Yy93bEZ6UnF5bEtaT2RKTGVyRSt2NERBSnhSRFJ4ejBJRzJ3eHF0MTVvOHM4?=
 =?utf-8?B?MGxwQm5CR2ZJRUdySUxaY3orcjl2d0NBaDJjenM3V3lIcTNpMWNvclR1SkhN?=
 =?utf-8?B?aVhiNjErMGZaSXQ2dDJxdW9LQmNtMHFzbEdhdzFxaVM0UGJHR09GTkhtRXBE?=
 =?utf-8?B?cWkrWmtWMXNuZ3k4V2J0Wk94VmtJamdLUFJRWmRvbWJUSTR4UDdZb3R1dFFj?=
 =?utf-8?B?TlI2MDVIZzROZUFXekFHSjNPZTFRR21qbUROYXNEcklDbS85SUkxcUdPSjRy?=
 =?utf-8?B?bVpwM1FrQTZnbHRKSWZ3VnFXVkF0MjBOelUxbVUwNlJxenlvZFUyaUJQb01p?=
 =?utf-8?B?cGpjRXVlZnFCSStzOUxNNkFXTnN3OGJQZWtZSFdsU1pzZGhKSEsrRFpURTZq?=
 =?utf-8?B?elJ4djZpeEFrZzVkUm5tYjBMQkN4SFQyeHU4VGJrSWZka204K3BROVRvV0hk?=
 =?utf-8?B?WDlNSThJcURiUnBsUUpZanlaL1FaWmFuY0trY3AvS2YzblBPM1VLaWdkdmtr?=
 =?utf-8?B?b0xORmRSSTd3UWpjeW1ZSmZWdmQ3NGFrM0hHakJ3ZHd3dktRZXhDT1RRRzZY?=
 =?utf-8?B?Ym9qNFQyaE51WHZHQkVSSEFndFJXaHlIdEFWb01McmpHcjA5aUxHR3RkVERL?=
 =?utf-8?B?UWpTYnV1a1N6QTRXejcwZ2ViNFpvS0s4Mlc4OHN6eWtYVTVBS1hDTnoyRC9J?=
 =?utf-8?B?aW1RNG5RQjZtQm5PZFliR0lsZGpGRVN6YWxrRnpYbktQNVlRTk5xUVQ1TjFk?=
 =?utf-8?B?NEtIQzAyQkh3K1JtMFh6S0RzZmJ3cDJXaHVsdVp1ZExpZ1M2N0JvSGg3TTU0?=
 =?utf-8?B?QzJpS1E4S3Q3OWV6U2xpMWV2ZWFlOUZuTTVPNHZTek9oRkVscFV5V09IN1BN?=
 =?utf-8?B?V1JFL09sM3B6NFRKUWVvYk9WNTV3MnZ2QUtwcFNMWUxuam9TK2o0M2lWbGJ5?=
 =?utf-8?B?VHcyS3lWUFk1dVlWSXNLaVdkc1dYa1ZVSVkrd2MwTDROaHpvK1lzR0l1UUJ4?=
 =?utf-8?B?a25qellmUE9Kb0JLaEhReTNZRS9zZnFlS2FsQmZmTzJxUHNMRStFVlhkaVMw?=
 =?utf-8?B?bE9kc3cwOVRwTTltZ0hqdi95NGVmc0ZIMkczdTJOa0VBditWcmpzanZnT3l3?=
 =?utf-8?B?clFmRnJmWVg3MzBHdVpRLy9pUFBiUnpnRllsVnpkUU5SZE52UXRpSFE4Q3Yr?=
 =?utf-8?B?dm9DYmVFMXY4TzROc3h1eUczWFVEZjduSHVFaExVOUx0aVpZRzFoZ0FSNWE2?=
 =?utf-8?B?M0NjNzlXTmk3QlZWWUQ2b3dnYUxkZHhNMWEvSVRtSGxyckJuenFyck1LRnZD?=
 =?utf-8?B?VGtRMk8xTE1KNHZ3Q0xpWjQ3MkZVamRNT0pUY3prYVdjYzlmOE1IRkN6VDRr?=
 =?utf-8?B?Vk5ENGxaN2RaL0Q3SjN6RzEwekorUGhKQlVRM1NHOVZqL1hEdGNWdHpmeXM5?=
 =?utf-8?B?SlRVejlZV2J4MzdSa0dxQjFHeldTckFTU2tTbExjdnI4RGh3V2RFMW15TUNz?=
 =?utf-8?B?TjJ2RndnOVNtc0gxRTdPc3lTVWNHM1FGZ29QS29uN2NNVEplVGQ2L0x4UkZR?=
 =?utf-8?Q?Mf7qpQe8LEtGBHK/kVjiKkArQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe43df29-0cab-4c54-71de-08ddef63649e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 05:40:32.8503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hjXVnRyWZBgbm2n0v68iTV9SFlZ0MhN6iGQr3FVDokY9tPhBZmVkLYvYaZup179FfzxnO6qGvZRP5vKT+tsivA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11583

TJA1048 is a Dual channel can transceiver with Sleep mode supported.
TJA105{1,7} is a Single Channel can transceiver with Sleep mode supported.

Frank, I dropped your R-b in patch 1, since this patch changes a bit compared
with V4. Thanks for helping reviewing.

To support them:
patch 1: add binding doc
patch 2/3: To support dual channel,
   - Introduce new flag CAN_TRANSCEIVER_DUAL_CH to indicate the phy
     has two channels.
   - Introduce can_transceiver_priv as a higher level encapsulation for
     phy, mux_state, num_ch.
   - Alloc a phy for each channel
patch 4,5: Simplify code and check return value of GPIOD API 
patch 6: Add TJA1051,7 support
Others: Update dts to use phys.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v6:
- Update dt-bindings per Krzysztof's comments
  "define if:then:, without any else:, for each variant"
- Add R-b from Frank
- Link to v5: https://lore.kernel.org/r/20250904-can-v5-0-23d8129b5e5d@nxp.com

Changes in v5:
- Update patch 1 dt-bindings for TJA1051 and TJA1057 and allOf entries
  for them, per Conor's comments. Thanks Conor for detailed review on
  the dt-binding patch.
- Add two new patches patch {3,4} to simplify code and check return value of
  gpiod API.
- Add patch 6 because TJA1051 and TJA1057 use their own compatible strings
- Link to v4: https://lore.kernel.org/r/20250901-can-v4-0-e42b5fe2cf9e@nxp.com

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
Peng Fan (9):
      dt-bindings: phy: ti,tcan104x-can: Document NXP TJA105X/1048
      phy: phy-can-transceiver: Introduce can_transceiver_priv
      phy: phy-can-transceiver: Add dual channel support for TJA1048
      phy: phy-can-transceiver: Drop the gpio desc check
      phy: phy-can-transceiver: Propagate return value of gpiod_set_value_cansleep
      phy: phy-can-transceiver: Add support for TJA105{1,7}
      arm64: dts: imx95-15x15-evk: Use phys to replace xceiver-supply
      arm64: dts: imx8mp-evk: Use phys to replace xceiver-supply
      arm64: dts: imx93-11x11-evk: Use phys to replace xceiver-supply

 .../devicetree/bindings/phy/ti,tcan104x-can.yaml   |  69 +++++++-
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts       |  43 ++---
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts  |  17 +-
 arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts  |  13 +-
 drivers/phy/phy-can-transceiver.c                  | 180 ++++++++++++++++-----
 5 files changed, 229 insertions(+), 93 deletions(-)
---
base-commit: da57e528a86120a1187edf3e2c9affb4083d342d
change-id: 20250821-can-c832cb4f0323

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


