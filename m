Return-Path: <linux-can+bounces-7172-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMiJBup6vGk1zQIAu9opvQ
	(envelope-from <linux-can+bounces-7172-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 23:38:34 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3062D3548
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 23:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1CF54306692C
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 22:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7583D408242;
	Thu, 19 Mar 2026 22:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LmodaY54"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013003.outbound.protection.outlook.com [52.101.72.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7888F4070E9;
	Thu, 19 Mar 2026 22:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959593; cv=fail; b=BtIUw3ULbPKMF9vL4q4xuQKFWihfEIquWAWf9P31kD3Kwco/mXrGQgjH4R/Fd+5uvdD7RdWHDQs0G0w/TNRlS8g3I1vbVEgIQuOuWrbBE3DFpOVlM/phKUZxBDrbCplBskrVZLKA3VYUiBpvehHAvWI+4mEuXaQ5ggZz/bc8iMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959593; c=relaxed/simple;
	bh=IJshm2W4EPDnFr9CpmYpgNjK7dzgwZoh4oxjlbLAs8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u0Sropyj2veUARK1g3N5gysUfvp5shBLcKiLpjTo8oxPNnDsMqlM/1DUCKE267UPriwN5whb5dMYR75VsihFHU0Fhq5egqYCgAu6VcJs/kcw3waBTR7OYzPWZV4JfSfajOO8EjS/qGGeVBESap5IGxUcLwAcKuplXUAgHbu1eUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LmodaY54; arc=fail smtp.client-ip=52.101.72.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EuulYQ7W33CN/TDp5jxjmWjbJwyxuJUO5BCebl7CNfQ756j3adyld+njzOfh9O0KrL5GKzZb2BRKb80ln31fY5vfA1obR9Albo7ABit0m5IzfRyG0n/hCvupKBFZ/mfsRMUdp2krVS4JLbnXiGcMHoCF/7J2gZWI5KCnFFZThIA5MjauDaPTfoGccHVa4TjqF3o7xPrxinkWJe3uWqQ+3lfIE1jq6PpcVGkm36BonEevuVSMZNaiHWUt/bf1XODEWwOjaKLkDJHtryn87IpZnsTH9PbUitofOtFcDsIzfH/dzHY6sgczuuuIiGdU/Sd9hfTNXco65KOdKsAETluSxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rs3UIyppA5PUh52RF+x00VFzk9rQoxkO5dEjZTtr3xw=;
 b=VynTGr8BWdiUJCHMxhwLlQbbkVAOvxgY4NDnuLMXAp71T2+Yx+A/FdoDn6WSAL3Za1qGggne+/xi0KoF+KyFpJ6fomEdxLGruT35gYt+/C0cxyVlq7tNuY5g5UiAhb3gAPjPsNK8lOnDzZXRb2e3yGS6VNJi/cluq9KYY3j2YgAPlUAkCR4Gcr8yS002fPUS1OSEsMe9JAs44YGEg4dSMqH6cMiNXv7SqTuy1DFzj2sGXBTmIzZO4TWReiYW/LYK/w4FurToLVOKo23qecTHzg76sby3XM52VTL1LFiwwNNJ3wCUdM6D4xBwpPnibK90K4krKBjnyaYrYjtHnLCeLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rs3UIyppA5PUh52RF+x00VFzk9rQoxkO5dEjZTtr3xw=;
 b=LmodaY54BHZT2PrKT9AuQvLQNRu3nWgpKC085kwAvxlP2AOUEzXllX2qSbjCqBOgKx2UaxxDv4TxX+Yd2bsnsxYQ1KA2AykBDdSjUZdxTqgpSU9zeQP0Oqu6cM96RIJNDSLArT0JWIPwLr34F4jgUibjPZIrcSQBY5CrRpPZg6Uj5UuDnLABdow8exckPGNJ8aIbj9BaB0l3B4AvCEsYh1ThrtQ/CwKwq6pOoVlFAS4YsDlAYqGsKAC16JA8K/PqJR1/RFCU2bpAf6qw4+SWCEpOTUhUWPHJF8e1hZxV6r8S3jPpXXFXsjp/DYjaoceTOmD9C26b8olTKmyTywgi8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GV4PR04MB11355.eurprd04.prod.outlook.com (2603:10a6:150:296::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 22:32:50 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 22:32:48 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	spacemit@lists.linux.dev,
	UNGLinuxDriver@microchip.com,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v5 phy-next 05/27] phy: add <linux/pm_runtime.h> where missing
Date: Fri, 20 Mar 2026 00:32:19 +0200
Message-ID: <20260319223241.1351137-6-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
References: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0044.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::20) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GV4PR04MB11355:EE_
X-MS-Office365-Filtering-Correlation-Id: f1d43049-1f28-4758-75c6-08de860772e4
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|366016|10070799003|1800799024|376014|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 UV+9Og6DqdXfuKTPRRnyKBRpz7+U+qRzGwF/fZF2K9tz8hEuZ91qwQG4jQY4qTHgYyr5htlfYZjIPzC222navIG5wBfbuod5EPpiIGPA72GEbXKECmAYQkPj0YWJ2v6c1R8uHJa8w/qCy67DKL3nFF7o+hRQUD/BVahKbH5Lyvjswg3SqQx2wHIAszJgsXPnJbc00dr81yNgqWTcfkXG+8SWN944HQ+nBq+9i0owdMNbNl88EWLeOgvA2EWnBtLldaPoypjjhMT+e7xRI0jFfckH7y24Qp0ZdtntQuLM376dSfJIhQu8eWGwLVxA4tdvs5JCbdp4nxAZA97unqlaXtOgT/xAlQZsGRmdTbnM/aHHrx3ACARGQbjsUGS+D3wScJO4WOegTBIBlDKoy7RortYXtxUI1FyuBftMed93flpPdEtR4mRO+93zxMP59tLb5eNuyfTyDvf8Kg1MM1CNM7i5l9Gl6HAVdG+oQLqHu9W/LpmaY/TBe0wvsGevAFUx9RmWP1oOsWPaIPIJW7oR9Iq7iwLcTm5w5A1RfOEr1vr6ghxQYtUvQ1vWH2xDWgZ0QszCKxQDjYqGQP8dYY3kllgtZ0DSjQesXWOpycW17SczI0bNj2Vezts449OWpBRZROFeGMaCKMTZaNCA77DzpK+jybyVPk0/PKhgNCS4FF3iRet7mzvUl73HZguaz+SXyJdKVIH3zVO8IBNlOxSGfxtIYxAYwn/vsesf7JxJYOs=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(10070799003)(1800799024)(376014)(7416014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?dExOSk9CUlc4NytkcHNqd0Y0Y2RnVnFFRUtlUW9qUk4vSUpCS3RtNUE5TDdk?=
 =?utf-8?B?cmQ2dnZncHFjcnRpQmI2RlFxU2N0bng5ZlNLeEFaYUhyWjhkcUpyQkVhbDBS?=
 =?utf-8?B?M2tqYjVrMkR6dHhFTVBCNVlBREhSUFJMQ0JLSUhLYW85Y1hrS1FYVDBJanA2?=
 =?utf-8?B?cFlHc2VqcWtqM3IwNWJlUEMrdEs4dnl4RCtpbmpPZUpNenJ3a1hyS2hVNkxa?=
 =?utf-8?B?RS9meDZhQS8rSVVIYnhpQThJZHZuUDJrZkg4UFhHR2c4MHBrM09VZDVpbTd6?=
 =?utf-8?B?SG5PVjRHamZpbmpURjRSTE5kaXZhWUlTZTNoY0prVTVxR21BQXQzNUJOZk1M?=
 =?utf-8?B?YnZwM09ueHA2Mmp5dFRqR3lseG9TenRFbUZucmZSZWtXWDNPbVJWZGVDM2Ri?=
 =?utf-8?B?Ym5NYnhsZDBYdHczL0Foc0F3NDBjYkNsY1pBdmhZYmJDWm5ScVZHTUM1M2Fh?=
 =?utf-8?B?L0JsVTh3aXNsZHBHQ2c2aWwxV1ZNdGkzT2NyR1NpdDVVY2NsYTlKbFZoM3cx?=
 =?utf-8?B?OFhtNHFzdG9JSDNFMkhteDJLUWxhcVNxdXhQODljU1dtdWNzZG50bFlwdndn?=
 =?utf-8?B?c0Nyb0pIendTRVRmdlNyRGlhT2YwbHVXTWY2dWgwOFBoc1NGZHZBc0hpc3JN?=
 =?utf-8?B?dU5XSVV4L3Bac3ExS2hEZGZCeWp6K1N5QUF4SVBaZWhkdkExWFdYTDZ5SzBL?=
 =?utf-8?B?eDVCTVdRUm83SlpaVExBTHdrUmE1MGhaU1ZNeGFLYkIvOTdOTWN4NFBOd3hv?=
 =?utf-8?B?bHFGVEFDNUdXeFYvNnZGL0FpblJHcUoxRkVEa2x4M1lNU3hJQWhwS2J6MXRL?=
 =?utf-8?B?M2VwQzd4SXVXTjRmRUNJY2ZCMFlvRU1qWG4rV1F6N2tFTmRXV2dOMkVvZG5v?=
 =?utf-8?B?UTdiL25DeGZuN3cwRDhrRVRGdDlLV0I2Rjl4KzlQaHY0a0dldldwVVdqbmYy?=
 =?utf-8?B?VGN3SVFqdVREeXFxMWMxNFp4WmlTV2plQWNxTGNJQytwa2xsRDZ0Y2h5Z3pP?=
 =?utf-8?B?ek5za0ZxS1UzSzFoZjc4b09sQ1pLY2VsNU1aSzJ4N3ZWeFliUkl2cFY3bkth?=
 =?utf-8?B?V09rZGhBWk9jZmFjNU5Kbis4blZXdzdvckhSRm1rTFNBQzNXa1R6Vy84YkxQ?=
 =?utf-8?B?dHpadnBSbSt5TTc2S1VndVpoYlBsaHRPSzhZSmVNNUIxS2dsbm5Canpyd1Fy?=
 =?utf-8?B?bXVlSXViTWt2dHQ0eGhoZnE1aXRsOWMrZzZNRGl6elc4N2xWNGwwUTIxV0Fv?=
 =?utf-8?B?Ri85dGpvQ1R4Lzg3U1VFcjRHUXY3WjRNRmtPWXQ4ay9Oc1gyV0U5MXI3bklj?=
 =?utf-8?B?cDJuRTFLcnpPZmFKQm5OYUhCcGFkQklpei91dms5aUdNandXdFNSSC8yTmRj?=
 =?utf-8?B?M3RvajhvZ2R0cGp3ZGlKQWZ1eTRFSnkzQ2VmN0Q0TnNvWFpxcDhQdS9vdlhV?=
 =?utf-8?B?dWx6OUxPWCt1RS95WjZ2c2pURWhEZlRnYUg2Z3cvdGlTcEZPclZoRkZTeWls?=
 =?utf-8?B?eWo5bGcrREM5U1IzRFdac1RrcmhWa2cvT1ZIdW1JRm1iNXRod3ZVeld6Qmsr?=
 =?utf-8?B?MWxQQTZPR2dxWEJHVVNSeGdTTTVyT0wxdkNsNHlzV2xndmZFQ0VVMnNTd2FL?=
 =?utf-8?B?ZURjR0lFblVqR3czSWx0MUw5TG0rU1RtN20yb01iQUh5R09VV0U5N1NCNENv?=
 =?utf-8?B?clpBVEc3bTRZeGxvc0ErdlhCdS8yZzBOZlJRRHFGYTdaUkE0NkFySXNGWXlH?=
 =?utf-8?B?Sk1UZkJGYnpIQ1lsU01RMXAwbnNvUEVtQjU0aDFKZGpqQWsydTdvUS9vbENu?=
 =?utf-8?B?SlpyNHNCanlJcXRZTWxTc1ArVFNlblpITjZRWkVRZUVLd1NyNE5odmlTajdV?=
 =?utf-8?B?THZNeDhEV0VCK253dDAyVkQ4MFZPa2NTT1FCcmtCeGxtejNIbzhGUnM2OEpt?=
 =?utf-8?B?dS9uY3RYL2J3NGpYMFRJUHFCS2xiRDJnT1FRTVZYdGYva3NYR3pEMG5ZV1hI?=
 =?utf-8?B?aEJWY1ZQNG4xM2xCRnFKS2llYnYxRGMwdmI3VFRjb0VGMUE4ekpRSlA1L2Z2?=
 =?utf-8?B?NTk1dDNxK2dQdUZKc1pSbWhrdFJYeVZEVGZUdm8wanhGS1dtY1lNOGR6TlRS?=
 =?utf-8?B?cHdsTktOb0haOHFLaFFuaDFKd2JYSEZBK3N5Qk01bzFBZnRnaTNJNU9lRGNo?=
 =?utf-8?B?SDd5WDI2dnBZOE5SR01vUjBsK1Fnd0VWUElsQ0JDOFZZcHNDMlpWOFdRNmtC?=
 =?utf-8?B?WGdXY1dPeGRnQWxiekZCc3pzWjNUMjVVYXVWeHVNR1JHZzlIdnYxYmdqTnBl?=
 =?utf-8?B?SzNBaW5PazlYM2FCa2RralcyZHhadGY1dktHQTBPYW82cFRBMW9jNmFpNmVk?=
 =?utf-8?Q?syiAPbVuWK3c3Afp28yZHOEnn1/0tsK7JsjWOmaUIytwX?=
X-MS-Exchange-AntiSpam-MessageData-1: wjwwsAfnU2w4osPajGUkiyRVda7dUhdNs5w=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d43049-1f28-4758-75c6-08de860772e4
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 22:32:48.6019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XyrC/9ufsrr7aRP6bqd4sqkKEoczmGRoa7YvZ4zEkUkD51BpSNCeZDfcYlyFVutuiEmeu/kp36hPKkkgISaN+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11355
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7172-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,glider.be,gmail.com,sntech.de];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,renesas];
	NEURAL_HAM(-0.00)[-0.990];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[glider.be:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sntech.de:email,nxp.com:dkim,nxp.com:email,nxp.com:mid,linaro.org:email]
X-Rspamd-Queue-Id: 1B3062D3548
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

It appears that the phy-mapphone-mdm6600, phy-qcom-snps-femto-v2,
phy-rcar-gen3-pcie, r8a779f0-ether-serdes and phy-rockchip-typec drivers
call runtime PM operations without including the proper header.

This was provided by <linux/phy/phy.h> but no function exported by this
header directly needs it. So we need to drop it from there, and fix up
drivers that used to depend on that.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be> # renesas
Reviewed-by: André Draszik <andre.draszik@linaro.org> # google
---
Cc: Peter Griffin <peter.griffin@linaro.org>
Cc: "André Draszik" <andre.draszik@linaro.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>

v2->v5: none
v1->v2: collect tags
---
 drivers/phy/motorola/phy-mapphone-mdm6600.c    | 1 +
 drivers/phy/phy-google-usb.c                   | 1 +
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c      | 1 +
 drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c | 1 +
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c        | 1 +
 drivers/phy/qualcomm/phy-qcom-qmp-usbc.c       | 1 +
 drivers/phy/qualcomm/phy-qcom-qusb2.c          | 1 +
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c  | 1 +
 drivers/phy/renesas/phy-rcar-gen3-pcie.c       | 1 +
 drivers/phy/renesas/r8a779f0-ether-serdes.c    | 1 +
 drivers/phy/rockchip/phy-rockchip-typec.c      | 1 +
 drivers/phy/ti/phy-tusb1210.c                  | 1 +
 12 files changed, 12 insertions(+)

diff --git a/drivers/phy/motorola/phy-mapphone-mdm6600.c b/drivers/phy/motorola/phy-mapphone-mdm6600.c
index fd0e0cd1c1cf..ce1dad8c438d 100644
--- a/drivers/phy/motorola/phy-mapphone-mdm6600.c
+++ b/drivers/phy/motorola/phy-mapphone-mdm6600.c
@@ -17,6 +17,7 @@
 #include <linux/of_platform.h>
 #include <linux/phy/phy.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/pm_runtime.h>
 
 #define PHY_MDM6600_PHY_DELAY_MS	4000	/* PHY enable 2.2s to 3.5s */
 #define PHY_MDM6600_ENABLED_DELAY_MS	8000	/* 8s more total for MDM6600 */
diff --git a/drivers/phy/phy-google-usb.c b/drivers/phy/phy-google-usb.c
index ab20bc20f19e..48cfa2e28347 100644
--- a/drivers/phy/phy-google-usb.c
+++ b/drivers/phy/phy-google-usb.c
@@ -16,6 +16,7 @@
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 #include <linux/usb/typec_mux.h>
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 93f1aa10d400..b9ea7d058e93 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -16,6 +16,7 @@
 #include <linux/of_graph.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c
index 8bf951b0490c..2bd5862c5ba8 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c
@@ -16,6 +16,7 @@
 #include <linux/of_address.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
index b0ecd5ba2464..d88b8a415e85 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
@@ -15,6 +15,7 @@
 #include <linux/of_address.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
index c342479a3798..f62e1f6ecc07 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
@@ -16,6 +16,7 @@
 #include <linux/of_address.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
diff --git a/drivers/phy/qualcomm/phy-qcom-qusb2.c b/drivers/phy/qualcomm/phy-qcom-qusb2.c
index eb93015be841..191040f6d60f 100644
--- a/drivers/phy/qualcomm/phy-qcom-qusb2.c
+++ b/drivers/phy/qualcomm/phy-qcom-qusb2.c
@@ -14,6 +14,7 @@
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
diff --git a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
index eb0b0f61d98e..8915fa250e81 100644
--- a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
+++ b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
@@ -12,6 +12,7 @@
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
diff --git a/drivers/phy/renesas/phy-rcar-gen3-pcie.c b/drivers/phy/renesas/phy-rcar-gen3-pcie.c
index c0e5a4ac82de..3e2cf59ad480 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-pcie.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-pcie.c
@@ -11,6 +11,7 @@
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/spinlock.h>
 
 #define PHY_CTRL		0x4000		/* R8A77980 only */
diff --git a/drivers/phy/renesas/r8a779f0-ether-serdes.c b/drivers/phy/renesas/r8a779f0-ether-serdes.c
index 8a6b6f366fe3..c34427ac4fdb 100644
--- a/drivers/phy/renesas/r8a779f0-ether-serdes.c
+++ b/drivers/phy/renesas/r8a779f0-ether-serdes.c
@@ -12,6 +12,7 @@
 #include <linux/phy.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 
 #define R8A779F0_ETH_SERDES_NUM			3
diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rockchip/phy-rockchip-typec.c
index d9701b6106d5..0a318ccf1bbf 100644
--- a/drivers/phy/rockchip/phy-rockchip-typec.c
+++ b/drivers/phy/rockchip/phy-rockchip-typec.c
@@ -49,6 +49,7 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 
diff --git a/drivers/phy/ti/phy-tusb1210.c b/drivers/phy/ti/phy-tusb1210.c
index c3ae9d7948d7..b7080403e649 100644
--- a/drivers/phy/ti/phy-tusb1210.c
+++ b/drivers/phy/ti/phy-tusb1210.c
@@ -13,6 +13,7 @@
 #include <linux/ulpi/regs.h>
 #include <linux/gpio/consumer.h>
 #include <linux/phy/ulpi_phy.h>
+#include <linux/pm_runtime.h>
 #include <linux/power_supply.h>
 #include <linux/property.h>
 #include <linux/workqueue.h>
-- 
2.43.0


