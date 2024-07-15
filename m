Return-Path: <linux-can+bounces-974-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A911931C8A
	for <lists+linux-can@lfdr.de>; Mon, 15 Jul 2024 23:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62CED1C219B4
	for <lists+linux-can@lfdr.de>; Mon, 15 Jul 2024 21:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FE613C904;
	Mon, 15 Jul 2024 21:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="c2+5TFkr"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012041.outbound.protection.outlook.com [52.101.66.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6323813C684;
	Mon, 15 Jul 2024 21:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721078857; cv=fail; b=Fe8a9SvvS/2JY8hAuGBbyroHF/AYztUQN+i2dzGt9vjkF5UxB0KUD2M6ahl0ByZPk5EpuouGZM3K6L3LTRKXGesaN1K3nHmgC1iO21fhzygRZNGIIqaXnKLlT03SnpCyAPGPDeQTiGIuAh0Kar6ge7gTyZ++Ysg4B1FENJQL7qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721078857; c=relaxed/simple;
	bh=RgC0CSrHrVR3yAaOFD/35JK4e/cxLtet6kIhQBSn/Ng=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=NQaFktTSMxgCRvanx7+KiSNSA+bfsiuNcZAGq/vrprMcGju8hxsPs1MdwS8vUbmKNqm8B04a78SAJFMy4sxv40OodEZdT39mXKh7T/P86smr8FGpToPcN2qfOA286BsbnkDXWd8WxmfnKtWd3W8UvW6nwk02ZRte/5qb+9HFXO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=c2+5TFkr; arc=fail smtp.client-ip=52.101.66.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AzEFt33mV05oxhJRoLGPl39unK8ZoaX+WufbzW0mQyJWLc1PLf5r4o+XaZJZTBynZZzvF+qZuS9sA8y+fc5G4vhXdjUrEZ/M1/m6JX79JU5Pp9TvAWeqWaoLIhQQhJeti13GANHGdn4nZ5SFbXC8T8fssz96mtDRlvAYm5/XyWHiPKpuL0o2UL5PVv1llj3ZZ83+fs7fdw1KG0xdFi0cw2ToRnDoY+QnRz01g6PYYc3uETSR2fnbGykmM4Tvy3N0roWfk9bILwaWBAx6ajsA9eUIHROIUkyWIBnCCHuoo0WCIj8EBTMWm1dCOqHQQj3L9Cf5jnjKtYxRxrTWkSkQrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ax1mS1oFEMQ9ba4vLvpBMDymrE0Dy3StrHtKasRnbF0=;
 b=lnBPLXSU87QjyjvjoGXh+it0to7+LOj6zsI7OtqIp+EGtXfrOCF1rsq0zLndPPYzqFs1dAkPR7pU5C4zedU9L3VXByuaTNPvxGEPtFRsq9wSDPDY9Mfw4YGmGJ+2eJfCY+rMGwBAyPP8aCHeLncg6eipX1oPRQkheOnHChHXc81cS6IhMfqQt0zEuqGYL0nblObXl1fHcVatqvBkex6yV1LvnS/EPFNgZmTlRnSAuAHMcc4NuOoddSBFtJENPfd9ptu55BcOGVCFNKwrV2vL+aB+78qxEkv+VKRwxpx2mTfvTIizg9CtTVSdfAey/zkumZ8KXKQ8GI2KNTlZVIf40A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ax1mS1oFEMQ9ba4vLvpBMDymrE0Dy3StrHtKasRnbF0=;
 b=c2+5TFkrJAoQzXpJxITxrFDENMkVAvNOhZnzHvByOX7U2mVDPD/MJadcQFtamM5hGvka1yLFLBD+QQSVzlVZgGaT7puS3FEFLe0gZ07B8A73RpCD3GktpXySRB+0t5Hhlt5pr0V9HFnblko223Tc/ZCTJdPoOlvUEn6OlYTopUM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8275.eurprd04.prod.outlook.com (2603:10a6:20b:3ec::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 15 Jul
 2024 21:27:32 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 21:27:32 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 0/4] can: fsl,flexcan: add fsl,s32v234-flexcan and imx95
 wakeup
Date: Mon, 15 Jul 2024 17:27:19 -0400
Message-Id: <20240715-flexcan-v2-0-2873014c595a@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADeUlWYC/z3MQQrCMBCF4auUWRtJYkupK+9RukinEzugSUkkR
 Erubizi8n88vh0iBaYI12aHQIkje1dDnxrA1bg7CV5qg5a6lb0chH1QRuME9h1astrgPEB9b4E
 s50Map9orx5cP7wNO6rv+DKX+RlJCiqXTShJKc2nnm8vbGf0TplLKB6+vh+GcAAAA
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 haibo.chen@nxp.com, imx@lists.linux.dev, han.xu@nxp.com, 
 Frank Li <Frank.Li@nxp.com>, 
 Chircu-Mare Bogdan-Petru <Bogdan.Chircu@freescale.com>, 
 Dan Nica <dan.nica@nxp.com>, 
 Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>, 
 Li Yang <leoyang.li@nxp.com>, Joakim Zhang <qiangqing.zhang@nxp.com>, 
 Leonard Crestez <cdleonard@gmail.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721078846; l=1599;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=RgC0CSrHrVR3yAaOFD/35JK4e/cxLtet6kIhQBSn/Ng=;
 b=H9yDxKLbtldRj1u2oqWFXWWOtaU6zZxL0x+euLLwm1r15Ay+MspefhaUOGJ8EhMDCEtYE3m+F
 LHfYMKNxNd9Bidj3Q8UL8fnTH/803YQqKyhOcxs4Hr/YnZey8D4cbhk
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0112.namprd05.prod.outlook.com
 (2603:10b6:a03:334::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8275:EE_
X-MS-Office365-Filtering-Correlation-Id: a3704567-08b4-4581-161c-08dca514efc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aTJBeld5ZlBNeGxzNkhmUjIzUDNZcFFmWDZkRHhOM1hSWTgrYTFQZHMrMmxP?=
 =?utf-8?B?YVRoUXc0WjR5N1FnOHZVNWd1eG5rRmkzeEh1ODFIUE1oTncwam5jbGV4blgy?=
 =?utf-8?B?K2pTMElPME9JSUZ0V3RWRm9KVnlmU0hFLzZCbHNZc09rdjZ0cWgreHhUK0tI?=
 =?utf-8?B?b3dzdUV2Y2FDSmVKbWtIK2ZXU0Y1clNiOXYvUURHT2ZNZ1FndUxGM3hoS3pY?=
 =?utf-8?B?S3ZVTTgwSlpkNGJSdDZ5TmtsT1k0UEZBT1JCdFpraFRILzc2b0Z6VjZHNExp?=
 =?utf-8?B?eHNtZXQzZ0tGMS9OalZHbjgzZ0FOcjlxNVJtMkNUTnFDTWJJV0t4bCtiKzlW?=
 =?utf-8?B?eFBWYjlPYVJSekRzc3VNNHE0TjQrYk5MV0ZWY2tObHYrR2hiRkV6WU80aEdj?=
 =?utf-8?B?ZjBGaWFYQjFWWnZhY1YvcFp6SXZ4d0JQSnEwUDllck9CMWFrc1BtWGY3cmlN?=
 =?utf-8?B?UE1JbGs5RWNUc1ltUU00bDdqekdiRjJ5eUV2S3p1dVdiS0JZbzRiZ2VaQnFM?=
 =?utf-8?B?SitzbTdpUUJwSEU3eWlUd1VvZGRmTElHUGZVNWw1ejM0QlAycnlPR0o5N3RY?=
 =?utf-8?B?ZDBNRTcxei9nU2NONVBzUnJYYjVrNDZQV3Arcy9nQUdVUkNmQkNGV0VYOG0w?=
 =?utf-8?B?aHdOTEx6SDFUd0dCM291WTFhWHFtZWpjWk5QTjlkckFDVTdzUitydTJ0QlNI?=
 =?utf-8?B?STdYQnNVNkU2VkVBcXJUTi9zRm8yR0RONzRhR0FjOWo0RkpBZnQvZ0lLMi92?=
 =?utf-8?B?cWV6MEptMzhUcmlhOVQ0RDhSQzNmUU9Pdmphbk82SWovZFpXUkg5TUp3MDNC?=
 =?utf-8?B?VlpHOWNkK2FISXZIdVBhWTM4bjdxbm5kdTZBaGNHMmlTYk1vTUh1YlUzTlJq?=
 =?utf-8?B?NU4rQVllU3JoYjNnc1dDMzUwQWprb3FPa2tJMjFXMUp2MVU5QTc1OEU0V0lW?=
 =?utf-8?B?aXMvZFRrVFkyQ2F3NVlOdUxiNXo0NXErNlhwdTJTZjh5V1p4Q2VDUWdVR29F?=
 =?utf-8?B?NkJCM2hnUldqcjhHdlI4aWpwN3gzUVV1VHNSbVNVUUNXYWFpR3VZVk9uOWRC?=
 =?utf-8?B?TTNhclhHQjdERjY2UmZ3dmk5cjdycDlrT2ZIQW1Tekc4dmJ1WGZBK0lVWE1l?=
 =?utf-8?B?Y3IweXhCbGZJbzl5UW5DRUtKdTlYZklNQ1pNRkdPUEpibUxIT1dIQXh0L2Y3?=
 =?utf-8?B?cGM1eEU2ZG9Ma0cxN1FhSjBzRzdXQ1BQaWZNU2ZORXBNL0pLdmtBRkVoLy84?=
 =?utf-8?B?WE41OXhqVGIzR204VW5XQUlVMzlyOTJXVEd4bzhIVWJIN2FHdjZVY3VmRHcz?=
 =?utf-8?B?a21PV0tGK2hGUC9pSTB5czZONktSUWYzdUdUaUlQMGtPV3AyQmI3bkVBMjlM?=
 =?utf-8?B?aXBZZVZnRjJtZzZqWHNuQlpoWGdueWJMaUttOVI4cVpCMUpvclBFaUh5ZVht?=
 =?utf-8?B?YVFIalI5RTNteC9ITm5QcmhKdG00YWhEZmJ6Znc0dTNxaHVJMTJENjRoUGts?=
 =?utf-8?B?MDVZV0NnbVcyMjJqZlNsRUcxM0pTNXB0SGF3MjF2MFR3ZVhnOE5Xdmxnams3?=
 =?utf-8?B?cnlJOUVWSlNIWTUwMXcySlJGLzhTWkNpMVFzeE85WkgvVllMbFJCL3hNZDVB?=
 =?utf-8?B?NG9xQkswK2svMy8raFcrODVlZmxKMDUyODBrdDFsbDUvRytEZFNjVE5laEtB?=
 =?utf-8?B?SDI4L2JNQTFZVG1yeERNSi9sM2N0d2lhV25RRmp2RE5xMzdLeXdBMTZIbUxo?=
 =?utf-8?B?akc4azFBVUE5eGc3Nk5ETDlRM05oTmxQRmluYkozaGFUdDgyVCs1VWM5V2NH?=
 =?utf-8?Q?O/ct2K4SS3bUgkWZoB1F2QsBrndSLF6rx0Zz4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anNMRDdZV2NYVmh5TkhybnhIemJpS1NPZnNWanhtYitJRHh1aVg0ZDJDaE83?=
 =?utf-8?B?OG53QmV2VWY2TkhxSWVEbDlIdEFSQUUyNUJQZWVKbDhjOEhkYzBhSVFGRmY4?=
 =?utf-8?B?ekRrbU90UEFqejRGVnFSRkcyQ0tHY1M3WldXUlZQdUVFbnlobEx5YTFQakhi?=
 =?utf-8?B?SnF4R29uVUF5ajBVSHVuNjdYUmI0dU9OVElIZkJ4QnBYUFdxNlpXZlFMTDFn?=
 =?utf-8?B?UUlxRHI0RU1UbTMvSU53S21jeUFYYTd4aWZwSUF4OEtUcnI2ZHpEckRDSmxX?=
 =?utf-8?B?Z21ISTFXL3hmazVaeXcrZE56SVZtc3BaNmZDRFRPOW42UkxTWnhwbHo3Yjlp?=
 =?utf-8?B?K2hEUmU2UGM4a2ErUXl1WC9yMHhTME9CblNlTWM5YlhuZy9uTFpjYzl5KzZi?=
 =?utf-8?B?d2o2cld5Z013S0I3ck1wdGFOY1hOb2VLUS9teWdzcUFVVExRZ1JvZnF3V0dz?=
 =?utf-8?B?aFB4THpXWkMxZVVUTUhla3I1Znk0RitralptUk5WVnRxd2ppRmlFQU11VEta?=
 =?utf-8?B?WkhiTmxuek14OUdWWk1qeHp5NUtxQXBhTEZHaURTOEpGZHlIR2creXcySlg0?=
 =?utf-8?B?S3hwK3p1UU5hVmExOXVldkc2alVDeWlZZnU5NEE1YlI2VGhoRkozWXVSUHdl?=
 =?utf-8?B?aTZUd044OFZYN043V1hXY2xiSlNvNHBPRktKU3RBY0hvNFRqcWJSV3JvNWN5?=
 =?utf-8?B?MDRxZ1hHeXRuRWY1UlZlbGtaZTBCeUhLbllWSFF4T3Z0K0cwRER4UXBHVHNp?=
 =?utf-8?B?QW12Vm9jamJ5NkNTTDRlT3hNYlBLMVlnajR5T0p5dkRudGFOczY0UnhQOFlr?=
 =?utf-8?B?ZUNaUDBtNW13MmpyMHhvOVhWMWh5UkprL0ErbGF5U0tQWVRnTEh4S3c5SFdI?=
 =?utf-8?B?K01YSHp3MFkyS2tFZFNaNCtmYmdBL3FoYm5IakN4TGlNQjA2Nm5iMzNXZUk5?=
 =?utf-8?B?a09GbEE2VW02MVUwV2RUZlpKY0NzcXdZNWorbmhxUWxjMnNEbjQ1RDl5eVl1?=
 =?utf-8?B?bS9vZTFaUFVoeDFRMER0VGhrN1VhZENEYU9QSWJjMXYyVVVGdVZpdTl3RUg0?=
 =?utf-8?B?S3g0eGV2WXJWVVRhTmM3aEo4Y0l4ZzFzQlVwTjNzdU5ERjR0N3JJTEZ1SGpw?=
 =?utf-8?B?M2xmUnJYSFZGZTg4dTNIUGVoT0lsTTNTenV0MnhvcDlPZnViUUdNZU1IRVBI?=
 =?utf-8?B?bEE2eXBiWUp0NWo5V2dpQmhENEtVRUZab3FXOFZhbTZlUWZ5dytSOEZBNVls?=
 =?utf-8?B?UTNaN09OMERLV1B2SW9NeW83MTRUeVViWkFzUjM5bE1vbEdtSVltMW14MHlE?=
 =?utf-8?B?dW16VkkzcnFjUUJNdmh1N2JCTkhrMkNHQkVxM2tvWWxCVW5CUDZ1RW5KTDVV?=
 =?utf-8?B?U0NBZXN3ekVSRTd5VmN0dUduNk1zalp3blZUUUw5bEVVT3dlOUxrd1B0NVV3?=
 =?utf-8?B?dDcxREppTUcwcFhmMTZtZnRCc0NOdlFzZS9PWkhRZkV3Q1NtZ0o1bWlqampG?=
 =?utf-8?B?cytOYVowVlJOemo3Z0hiQ1JuZXZMMmxHTmo0dUFPTzdJTTlpd0dCa1BhdzVa?=
 =?utf-8?B?bzA2RlU3WUlqaC9PY2JsSitEbzdYSVFrVThkeEZzTGlVN2lsOEtGK0U1UG1i?=
 =?utf-8?B?eEwyUkVVVXVnYlF4VnJaVkpYeE5xUG11akUzQmtFZU12eFExNGY4cWl1aGdm?=
 =?utf-8?B?cVp6TVVNb2psZENDTzNaNnc1QUFJRkpQS3Fpb1RnRTUyYWtoTk8yWnc0UEZ0?=
 =?utf-8?B?SnZPM24yNGp5eitHbDYyaHVsWDZpcDNXbk5PM3BHZDNrc1B6QXFiUTZSeFpz?=
 =?utf-8?B?cjhHNExaYS9lelBRWkxzQmZwd2JOZmhzaHg1LzIvSGVudzllSE8wVUZ4WTl6?=
 =?utf-8?B?RTZtZC9FcTFJcGRKOVBEbFoyT0NOTzJpVUozSlkwNVpPbDBwUTV6QUVsOVNC?=
 =?utf-8?B?MzBXRkVQdWZndkN6RWpjNS94b0p6QjRSTWFLdllQRGdadkIxN0pWaHBESG1s?=
 =?utf-8?B?YXlicG16amJDVlB3YkxBNjk3MTNwMnZpaHRQbHN0NDVkWkFhOHk5dTV3Y2do?=
 =?utf-8?B?Zi9oZkw2Q25zYWFsamJUN1dYb0lZZ0dTNS85RjRGYms5M3FJbGg0Y3J0L1Y0?=
 =?utf-8?Q?nPwc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3704567-08b4-4581-161c-08dca514efc8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 21:27:32.1621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r2lQ09D51S9J8ZC2s0RhJuQ9PUWGF3rXO/oWyHaaMYOFr3E1BclbAmWrs6NDSAbPKlf3NetyVS2zSrq/r9oKig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8275

To: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: David S. Miller <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: haibo.chen@nxp.com
Cc: imx@lists.linux.dev
Cc: han.xu@nxp.com

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v2:
- fixed typo an rework commit message for patch 4
- Add rob's review tag
- Add Vincent's review tag
- Add const for fsl_imx95_devtype_data
- Link to v1: https://lore.kernel.org/r/20240711-flexcan-v1-0-d5210ec0a34b@nxp.com

---
Chircu-Mare Bogdan-Petru (1):
      can: flexcan: Add S32V234 support to FlexCAN driver

Frank Li (1):
      dt-bindings: can: fsl,flexcan: add compatible string fsl,s32v234-flexcan

Haibo Chen (2):
      bingdings: can: flexcan: move fsl,imx95-flexcan standalone
      can: flexcan: add wakeup support for imx95

 .../devicetree/bindings/net/can/fsl,flexcan.yaml   |  5 +-
 drivers/net/can/flexcan/flexcan-core.c             | 54 ++++++++++++++++++++--
 drivers/net/can/flexcan/flexcan.h                  |  2 +
 3 files changed, 53 insertions(+), 8 deletions(-)
---
base-commit: a4cf44c1ad6471737cf687b1f1644cf33641e738
change-id: 20240709-flexcan-c75cfef2acb9

Best regards,
---
Frank Li <Frank.Li@nxp.com>


