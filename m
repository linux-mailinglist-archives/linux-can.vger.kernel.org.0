Return-Path: <linux-can+bounces-4384-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE19B3B3D8
	for <lists+linux-can@lfdr.de>; Fri, 29 Aug 2025 09:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2DBE165C45
	for <lists+linux-can@lfdr.de>; Fri, 29 Aug 2025 07:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B9A262FFC;
	Fri, 29 Aug 2025 07:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TXuEeBpc"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013044.outbound.protection.outlook.com [52.101.72.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3116B2620C3;
	Fri, 29 Aug 2025 07:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756451367; cv=fail; b=sEuUSQrP7d2GvEZbK7NeZ/INWpvnDNakxPUZd+GayY5wp5Z+iyPfNNc1OZqy38iQixOfnM2A3ayUSDRJnFtANeyOPts2TlYd6lvmHM4Fs2SK0Cy/SwUuIWCV1NOm71fb3cEK7LNynlS5EwyXvw/HNd2jTxQgqQJnCEL0rmb5GEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756451367; c=relaxed/simple;
	bh=6WJgehd9HBs0Nmyefae5kjMZ2I0huwvGLJv7Lst8mrw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=hbDmPKBMcxpZeSSEnn6tb6FLz5N63fhsppVVDfBbJs9pAdl6hUwrOd1mGVUbdSW6R0YMxocVRJOhXaAoz2+NmDt+haMnxtngwBJUWlqQGRH1ytQlhx7kC+kF1WmvqdHN7vz5t068O3bb2xv7I4o3uGt9uRBL5YY6w86GlZFCH34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TXuEeBpc; arc=fail smtp.client-ip=52.101.72.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e9jAChE8c5Z2JSWlBQRPyIvJc8GQ8tBUIVfa7X94G13zqV+DldzEXwvxVhxSO6K/eMp7jdQ0KdJxIn27l7b+ENZpn1LnCjNMA01u+z5jl3Hz7x2SQAR+6z9IhX08pnhcH4s8VCikA0XjnZPmrH7JrfPV7rAxxU78lqFnRVsM7wThzIEge696VKTfm9DcQ0IxXyYS3ET5HGecLYDViMxtx49jGd2ti1l+/LhKukC6kzcpUn4TFL8pZkX1DcWW0fAPydxBiHTpNlqXznGEvVfK5v0iTBFi6LJzFn09zoxWK1YcC1Yx6REV6B+y6txHzmj5RB1A63c0My//AiqGtRB/OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88CMiw/A1UdpcR3TTgVjC/a2dAAiKpjtDldh5GyGpcM=;
 b=BElZx5HEdqCQ5Sva2MnGhYvCK5pcf/qA1jMs8j6il/yG5hGFK6IOEdVY5vrxA161RcRHWsppBO5M7/tKm4HLg8VI5NKJ6WMr1tiNY9DzP/KY15vR9WBrv/KS4c8XgMLDlfqMJNAVMod4NWN4rhG+evRcaWGV+PErp408u03WaArhRwPTIYtj4mU2ispH8CH9K3P32uY7lxbPeJQkFRZ1hP3F+OBIdOo5Bx56YtIgXH/ATspdWgL0sJVhmpEFvQdNL1RuHYUK+uN/NmL8k/LZlKV1WfarCgeeruZBPB7ctO6jHnnWy1Z7Sita70Q/AXKm5hIgVxwFfdWWlCDXVz0J2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88CMiw/A1UdpcR3TTgVjC/a2dAAiKpjtDldh5GyGpcM=;
 b=TXuEeBpcE5nfS/BgyBCCJl8RCGfRtNYoqgBwARg5MImFrb2unATPJldX3HofAzYQ7kkHttUN7EIuDSR3p9IcDJL/vMXXQkrs21nq49gaWWuwb2v6Enya9gluAUVfELTT5R0SgD/xWPXtR5AJLH81pScZ6Vk2hp0YPr2OjxHYSEWDO2a8k2Lhn7HfsxFFZdfk8BwPx98cDw0omQC38jU01xG3/C37QRFlN27P3jZCEFNlMDHzop6FAV7elQWZaOUf2zP9er345hzEs7GOy+Ja1UogZfTobOUmJ+ntns5Crr4vnA3KI67F76N59abTXg8dzIOH33HmgwzVzEyCwMnyew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB9144.eurprd04.prod.outlook.com (2603:10a6:20b:44b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.6; Fri, 29 Aug
 2025 07:09:23 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 07:09:23 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Fri, 29 Aug 2025 15:08:56 +0800
Subject: [PATCH v3 1/6] dt-bindings: phy: ti,tcan104x-can: Document NXP
 TJA105X/1048
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-can-v3-1-3b2f34094f59@nxp.com>
References: <20250829-can-v3-0-3b2f34094f59@nxp.com>
In-Reply-To: <20250829-can-v3-0-3b2f34094f59@nxp.com>
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
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756451349; l=2017;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=6WJgehd9HBs0Nmyefae5kjMZ2I0huwvGLJv7Lst8mrw=;
 b=pXBBTHm2pRI3yV4DuAkfW1LYNfO795tUIwkCdBSQNKf/ZGAV0AZv7PAe6miJ/38dEoF8CxYh7
 QdFHrzZsk07CYhYjMnU8Ht4LE2TguW5/3q40ESYr757Qob7O6tC/ZxG
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: MA1PR01CA0172.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::16) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB9144:EE_
X-MS-Office365-Filtering-Correlation-Id: 04cc47b2-c30a-4ca5-933c-08dde6cafb4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|19092799006|52116014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amdGN2ZrNGpqVWNMMTZZQk1LMGNEeS9pYjR0OC92UmZjRUVBS2Q5M1NNZDNh?=
 =?utf-8?B?YnF0cmZ4dUdkc3kwSmpPbHk3R2UreGhxcW9YQThudkFRY3RVNFRQYXE1L2lw?=
 =?utf-8?B?OWNhL1IvR0VIak5oV2Frb3RTUEYrRHBKMGlFNmFIT2hVdTNPaUVFbWRyaHdi?=
 =?utf-8?B?Z0M0RDJMOFZnMUp3eEdrdzVFUVVvYXNlWXhMamcrWUd6dEYwSVJTU1o0Tis1?=
 =?utf-8?B?eUxsNDliYkJBM2JQSjFxTVdpcnBRMGFKNXN3WE50Y292RE5vL1QyeGtMVFBv?=
 =?utf-8?B?Wm1zaUNscUc0Y20zYU5rbnUrYlZNNTlLWDlPd0hwa3hMdFlwNzkxRUJxa3dH?=
 =?utf-8?B?T2tON01tK0M2dFJSSk5HOEo0V0E3OGFERTBLR1VaaDNiQnFFUWo5WElEWXlu?=
 =?utf-8?B?UlpiN0xscWhYRnViZzJMZms3aHhFVFpXWlU1aVl1am1iY2RHRzNpTkR0eGVO?=
 =?utf-8?B?Z2R6UGJZdkhwSTZIaEFjcTZTR3VSc3FJVkJGa1dYbmFpS2hwMW1NUXpGbUg5?=
 =?utf-8?B?WVI2VzNSRjFhSlBsZkNsM0cwVk5GMGRhTnNVZ1hNNzNxdG4xNC91bVNER2R4?=
 =?utf-8?B?NUYxWHM2ZXhXYkUwbnZVYU5FRm9ra3FLRElzc2JYd2ZSNWJra3ZlNXcvUjJv?=
 =?utf-8?B?eUhUWnhSRlpwelZsMEwvbGJBUzF3V0RKdUJpcG4zWG1tL24xUGd6ZVhqNllv?=
 =?utf-8?B?aHJqVklKaHlWWG54YzA2cUs3YmpEeDlZZXJaMUJ2ZjBYNEd3V3FMeDhYY2hN?=
 =?utf-8?B?UnFJMWZIY1YzNFhOdWlXWitFblhEUnRUd1ZMVVQzaldZbWpSMzhMSEp6S056?=
 =?utf-8?B?RVBHdzViZzUrdSsyMVVJZHhiU1dnWjlvRjBpZndWVTFCc1pTZzJhWnBqZmFr?=
 =?utf-8?B?RDBBdm82SFFHUVRPUXRqNmVBSFYwaUZjcUp0S09CR0h5N2Y2aWhVcXdoVkV1?=
 =?utf-8?B?R2VyUW1WVWQvTHZOdFBEUWpoc1B0ZEhGSnF0N1FkK1JKbkdSVXZMaWJubEZj?=
 =?utf-8?B?RXVXZThlS1BmVDRFcDFIODM4aXg5dEZwN0tTQTZlOVpwQi8rMytvd0p1dFhk?=
 =?utf-8?B?cnp4ZXVmUmgzVis3MlZ3YnhLYzdtdU0rYnFNTjhtNk4wdHZkak5rSU10QVFD?=
 =?utf-8?B?RkdyZHNnaGdMRUY2WVd6S01EK0VieFhuS2QySnFSc1M3c2xERWhPQlJUc1ZM?=
 =?utf-8?B?ZW90U3VCa0VOemg5Y08rTjBieVVvb2U2V05xeDUyOTNLa2dQMEpFV0dKWjVt?=
 =?utf-8?B?U3hFMGpUMXRQUGliNlpIaDY5dWRCK2dpVUdpSS9XVGV1UGpQZ2lLczlra1Rm?=
 =?utf-8?B?RXRUZEN2MEhWL0JZSk1MOGxOWDhReDRaRTJJVS9CTzFNN3Flak9aK0wzdGpQ?=
 =?utf-8?B?bGRGUENwTVhLaDB6bzJWWEV5TENYVVhXaHVMMzliZ3BmR2xQdysxdWZjaDlM?=
 =?utf-8?B?SFp0eEZhbWs2UExDeXlFOVlrSU5mUFdIZkg1VFRxUXYyOUw3N3Y2RnJTSjRt?=
 =?utf-8?B?NHdoQy9JWWRTL1Z4MzBFUUhNZklUcGYyWGFhY0JMcTlDR2haMXFjMGFmbXRt?=
 =?utf-8?B?UHFlTzVEOVhtZW82QXVZZkxZUmF5ZFoyMHc3MkRJMDc4SWRmL1YwUUlhMzRT?=
 =?utf-8?B?TlRCd0xLNzNqbEgrakptZzNKdXAybkhGckV2eGJqenZiSTlvV2FXN1p5alNQ?=
 =?utf-8?B?SkNFNXowTjFKRzdrOEtKUmFISjRCdUFJbEZpdUtwVGg1NjBXdVNLRGJGeTJL?=
 =?utf-8?B?elZxUlBGQjI1Zm1QSGpvTE4yRzZKc3BYM3FjRzhzMXVpSkJRU3dDQlZoc2NB?=
 =?utf-8?B?K21jT1BnU2FvUjkvOCtEcUxlcXJneXU1ZlBxa2Z0b1orMnZNZGxoVC85YUo1?=
 =?utf-8?B?ZS9wRThYc3RUMlpwTFBBSGU3dURZMWRYOGdiUyt2MUpRd0RvZUExajZIbzhP?=
 =?utf-8?B?NGZKNERFV2RyTVFZU3ZZK3Q1b2dTNUZQOVZDWkxLVC9lTGNDWFpVSHBTOHRI?=
 =?utf-8?Q?MWAaC08387G8C85CMZr96ypxCB60eg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(19092799006)(52116014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVQ1VFRBanU5TmNaWGszK3FtUDVmZEMza2NKVCtQbThwanpoMHdWQ2xxNUVq?=
 =?utf-8?B?MHA3RDhBZ21jazU4MkJ0c3M4MjRMV05iYTdXd09icUtjSExieVZUbndwcm9X?=
 =?utf-8?B?UHNwVmtZdzRJV25RTFJKUG8zYXNzUzF4R0lhVm1zZHJXQm9CblE1QldtRTZI?=
 =?utf-8?B?bUJiNDBNQ1hrYzY3V1pTcTZkT0hDNE96bU5qUTJlN29JTzZSV3VsanZYMHZo?=
 =?utf-8?B?eGFtRDJKSHE3Y2RjcnRtSDQ4SG4zaUNQRHBhRG5XWG0xK05xa1ZTSUZkRXN0?=
 =?utf-8?B?TllEdDhKM3ZLd3Bld0JYRkcxekRxNnN5aW15UFRUTWV6T3VQUFZuM3hOcTUr?=
 =?utf-8?B?b0VsOWtwTE1lTENSeS9SZDFIdVRJbXYwRUtwUE91Y09tTitFUUt6YXJSdHJO?=
 =?utf-8?B?cTl3dk5POFMza2xmZkdscnhsUTRYenI2bU5TMXNlWkY3VnpDTWlvSk5JaGQ2?=
 =?utf-8?B?QWZXaW9ISDdoLzd1Mkl2MGI4SDllSTNxVmZreU8rODRITWVSQURyUmhzWktr?=
 =?utf-8?B?QVVWclJBS2FxcWZPM3N5a3dEWjdhK1pXakhCZHVTVTlIUGFSbmRBbnZHd3hh?=
 =?utf-8?B?VDdLZG9WTG9DUnlIbDRxWFdGZGtEZGNYYWczblVXZHE2ak1vVjRtcjRiVTc5?=
 =?utf-8?B?VDZKZXdnd21XN0M1eDg4OWJjbUJXY3RRSjF5Z0pCZGZBVmZvYmhtcFUxaENP?=
 =?utf-8?B?aTB4UWl3dUZVQWkxN1ZJdG9PTVJtSm1WQ1NLTjhYeFkzenI3SFJ5YWdabnJL?=
 =?utf-8?B?Q1IzM3VqMXY5bVo2alpSVjg0M3NXZmx6dWkrVjEvalZDZnlqSTVUbEFqTm5E?=
 =?utf-8?B?TFhsK2J1NnUvbjI5Z0lnNENwTkZrc1ZMci9KYldleENlQjFaYkhoeGFJL0pr?=
 =?utf-8?B?bVJOWFZYQksrMVlDQ1UxK0JBbnVxNHJNMzNVQnJGSTBUN2YwR0NvSE92Z2Ev?=
 =?utf-8?B?RVFMSlpPQkd3NE1pbDdpTlEyTzhhaldxR3IzdkhSdXlFaTJFU3FPTFN6SEI2?=
 =?utf-8?B?VjdZVklMSzJudThod205cHFnYlJXaGNiNXRldHh2c3ZkbU9ndG1YSVlzWE1B?=
 =?utf-8?B?YXJpZFpCVE1HT0FYSkRPbEc4aTNZUXV1KzFiRzNiY0s2NkhhOXQyVWcwSUU1?=
 =?utf-8?B?M3lDSHFTK3RIU1EzTERpbnRCR2JjcFJmN1I3TW1sRWpJbDM0VGh5SmJWWXlZ?=
 =?utf-8?B?MEZaNkwwbWVtaktnTHJDMXBVLzVUZndHT1ZVNkllRHB4L1RCQTJqeHFXWmV1?=
 =?utf-8?B?RWtIRUdzbWdWQXNlU2ptbUNkbVlDdU5HWk5lR2E4WFA4ZzUwci80enFwaHBH?=
 =?utf-8?B?KzE0VmRWYXQ4Q3E2QTRrMnFoVmwvS2RXRHgwdkN0WUpzcHZqM3pKbFhPY3Fq?=
 =?utf-8?B?c1ZtS3lBMjAyRkNLNktFSFE3eGM4SlZOV3UzRkU5ZTdOTVFZcElNcFk4cmFh?=
 =?utf-8?B?Umt2RG9KRVJFNkcydENFT3hwTmtjaUNYYVRDeUlGT0NvYnpnREl4UHBRZFpk?=
 =?utf-8?B?Q29xTlo1UkdhN0R2NVFweGtZa0NFcU1NV3h3N3UwZ2dBaUl6TjM0TmNvTStB?=
 =?utf-8?B?bStVZW1KMG1WOC9ES2NUd0JOVlNlZUcvS1p3WkF2Q3BSSmdtaXZhWHdNSnBL?=
 =?utf-8?B?UVpONG95WGVQMlFnY1lMdEg2R3E4WVdrSW1aSlFuNnd0a3NjcW1aQW1aR1Vr?=
 =?utf-8?B?bVVPcDZGbmNyKzFDMDFYbmNtTFR4ZW9pYmtQMHQ0Q0NCY0UwT0pZVm5pTTVx?=
 =?utf-8?B?YnIrU3Z4QXlrOXY2SUxxaTBlL0duT3FoTFFRM0tQK3ZsM2Y5NWFyQlNFbHIv?=
 =?utf-8?B?eEk4U0pxK2FBWFR5dTd3TitPRWYrR21SM0k4T0ZuQ3NJY2l3RjBkMm5PT1VR?=
 =?utf-8?B?K3ZRMVJLMm1DUTdMa1FmQTF0eHducDFtaHBteEo5dXNpVkdreEd2Z1hLZTVR?=
 =?utf-8?B?NjNzOUhvMFVVOWlGdTEyTFNyQStmb3Y0NFdQSW5aSkhiSG1vUHFYZ0Q1S0Iy?=
 =?utf-8?B?U1ZWNy9vbW00a1IvR0pod2Q1UGdiS2gxckYralkzSGp5Y0VZaWdlREVwUmh1?=
 =?utf-8?B?dUc4TTJCS3A1NmtxejA4eWNyUXovUHdKWnVFWU1HODNrLzA2WnNFNlVoSmI1?=
 =?utf-8?Q?M0ovGYyInCeGytJ7sosorD/MI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04cc47b2-c30a-4ca5-933c-08dde6cafb4f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 07:09:23.2307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZDjYHjw+qTHWgbVZ5pA8LOKnbV0kMAdEz4ib9u4BddsRYHD1EUO7xs4e6eMLmrX5EnfEW7NbCWUI8KmxeRmmJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9144

The TJA105[1,7] is a high-speed CAN transceiver which is a pin-compatible
alternative for TI TCAN1043 with sleep mode supported, and has a compatible
programming model, therefore use ti,tcan1043 as fallback compatible.

The TJA1048 is a dual high-speed CAN transceiver with sleep mode supported.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/phy/ti,tcan104x-can.yaml   | 32 ++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
index 4a8c3829d85d3c4a4963750d03567c1c345beb91..a225540545301e443e3460b933effbad48786597 100644
--- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
@@ -19,18 +19,25 @@ properties:
           - enum:
               - microchip,ata6561
           - const: ti,tcan1042
+      - items:
+          - enum:
+              - nxp,tja1051
+              - nxp,tja1057
+          - const: ti,tcan1043
       - enum:
           - ti,tcan1042
           - ti,tcan1043
+          - nxp,tja1048
           - nxp,tjr1443
 
   '#phy-cells':
-    const: 0
+    enum: [0, 1]
 
   standby-gpios:
     description:
       gpio node to toggle standby signal on transceiver
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   enable-gpios:
     description:
@@ -53,6 +60,27 @@ required:
   - compatible
   - '#phy-cells'
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nxp,tja1048
+    then:
+      properties:
+        '#phy-cells':
+          const: 1
+        standby-gpios:
+          minItems: 2
+          maxItems: 2
+    else:
+      properties:
+        '#phy-cells':
+          const: 0
+        standby-gpios:
+          minItems: 1
+          maxItems: 1
+
 additionalProperties: false
 
 examples:

-- 
2.37.1


