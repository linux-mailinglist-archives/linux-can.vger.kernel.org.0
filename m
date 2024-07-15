Return-Path: <linux-can+bounces-977-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE0A931C97
	for <lists+linux-can@lfdr.de>; Mon, 15 Jul 2024 23:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C037B1C21B9A
	for <lists+linux-can@lfdr.de>; Mon, 15 Jul 2024 21:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF99143891;
	Mon, 15 Jul 2024 21:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dIrH3QCw"
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013062.outbound.protection.outlook.com [52.101.67.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760AC13D244;
	Mon, 15 Jul 2024 21:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721078870; cv=fail; b=opu7D1OZkowHtnnKWc+hy2uE+qn1A0krWOJCNgVQr6TOXavxoYhrnPFkR0OE1QX5w9h0pAifotAvwc8Kuputc6DtXqlvIgrqEW77qYFUoFO1ALQAhhR47PmkafaI9xE2eLZ7Bw5YL9X9LO0BSNHqnLjL2VnyCjfstJspIl8XA08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721078870; c=relaxed/simple;
	bh=+DIGgBkBWyrtYQfrFvCkUgA9e8HOpEMFLYOPNyi1qdI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=YJ5usrdSwKMrlxx9zD+7aFWVlYfDVWUoxs1T5CUeN0M8TyOYFzmteNnFG4hnA2fpO22uPAwzH4Dino7aq/NvieCa3XplIEp2QM0qA8CFx2Ae1NHxFmkBN50YNutNzv0t0FKRTzSGWuzDpCAA2qMkqwoXU6UEGg7fejDCncbg6e4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=dIrH3QCw; arc=fail smtp.client-ip=52.101.67.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ig2af21ikcnm98MR/N0imjFNaX6MEDFH7mIZ1YojxZjcSFmi2wBLZahaumG+q8EkfPZSmMfiAcykSTBgK975p6lm91tQxAlKno0FEhprIyfLwZaymNj5Mj2MgytDXM7XgBq4T5+5tVdcA6m2uuW/Wm7x8O4QQsAUuq71FqonLU6hmebm8wBPKfz6xYS35NXX7V/QJEdSukU5sP5CRSEO9JJafvmJe3yt0MFKFfRdfQRjU9ClDuBTaHBv3MyHSovxC8GUuLcMrOhrI/fgs6xvCdggtakJS9LWAMmwOY2h1EeXUZ51ZCTOswrkmkJuum77Z+lF/SMAqInc+TYbBvVZcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOd6FLZLIcIbPo0Sq0J+NOU0MeVyh5JVCAAuAq9yNW8=;
 b=CUGNBJKIWow+ZfOZuPSzyIQ7YZQ8APcSqMJzMSbcKF9olySYVtqCDb6pwzxkoTxCblAFJK9Y3gspkDYol5JST+nUK/KAzmurI7weK3FTBCuCSJzG3PANndHNKYR9ZoSMnYHu6Bvugq/zbHhaBt1TRAjDL/szcL09hrjFETLuumGxi/bvuf54tf8IDXbY5hsXZNEKOA1hSejWu5OuOKZrVWD71m8JAO3jnQ9x27SCJK/Je76o6KGp0uQXRi8/LUH1HntuxrZ8sEOhCyg09cOyI+8T6ThH4idYrQzBggRjqFHw9nDlXBXmRpQNon102O4kUdcwrVunF5NMsVBUnJ7CJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOd6FLZLIcIbPo0Sq0J+NOU0MeVyh5JVCAAuAq9yNW8=;
 b=dIrH3QCwXRf+RUedjVVVoqPKj9MSQnFUiEhGQnCm4kKTipTLYKYXZe1t7XvyxBZ4flYsbtWiidHEf32WuimQ5gob3oG+CiQksi1M8ISQsT+vNs472RClRxw28xIYgn7Gqt6CbnkbxQEh/FGB0PgX/LOkI6lAeL1Q1Xqoeqa7pjA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8275.eurprd04.prod.outlook.com (2603:10a6:20b:3ec::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 15 Jul
 2024 21:27:46 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 21:27:46 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 15 Jul 2024 17:27:22 -0400
Subject: [PATCH v2 3/4] bingdings: can: flexcan: move fsl,imx95-flexcan
 standalone
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-flexcan-v2-3-2873014c595a@nxp.com>
References: <20240715-flexcan-v2-0-2873014c595a@nxp.com>
In-Reply-To: <20240715-flexcan-v2-0-2873014c595a@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 haibo.chen@nxp.com, imx@lists.linux.dev, han.xu@nxp.com, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721078846; l=1301;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=27/RZ5zCVbTg9TNZoQv/itKKz/Wfggk4JwdgIMWCZlY=;
 b=fJ3phZR1p/jFldbpDbJDi1FK+wACaCi/Wi7FrA/TFPg/46DJ77j6EkJCMHnQkWLIFmKolO7L2
 l9dJ/kl5qe7AW3KG7xHvwZ1VEu6E5PHbxi+d/XUyxsMDneA7GoaW25f
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
X-MS-Office365-Filtering-Correlation-Id: 6eb2b2cb-0352-47a8-333d-08dca514f801
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wm5Hemo1YldXaGdZWks4aWd4R1dxMkVlZ25JalBJWnJrZFVUN21oa1VCWXZJ?=
 =?utf-8?B?WkNNZTNYQjhzOWJKMWFsT1RiSVBGNkR2alVCNFBJdTNZOVk1YlpSSDNnd3Zz?=
 =?utf-8?B?TTk0T25Hd1A4WUpHMGcxZ0VIL01QV3VRSEVMcjBNdjlJK2JaeU9nWmI3UTk1?=
 =?utf-8?B?dFUrUEtNelRmVUQwVUdON0huSEZNTzgvK3RCcDAvSmNEOGIvMVpySHB4bzBY?=
 =?utf-8?B?V0FzcFB3d2diNENUSHp6MW1Cb2t3N1kyNUtnTlcwZ21hR0hrT1pwUjQ5Z1hv?=
 =?utf-8?B?Ni9mSU1Zc3l1bThKSlBLdnFlSGtMenhlVVM5OW56YW8wYlJVS2dZNE42c0Rh?=
 =?utf-8?B?S2V0aExTcDFDeWtLYzdkdFNjcE51TUFiYXdlNXFXbXBmQkh1dml0SXRaWDRn?=
 =?utf-8?B?K1huM1p3Q3J2c0ovUFlhUXBwbzV6Mno0aXR1UEZwUVplNjVQY3UvMHNxUXNV?=
 =?utf-8?B?R3dKQU9KTTFLdjZLY29qUVVIRjZvWUtvMno1ZHRNV3pQbzVkYzVzQkVkZVQ5?=
 =?utf-8?B?S2tuS3FHeEdHcGNXdXVnQWlabU1BSDYxZVh5RGVBL0wvK2NDSS9CQ1ZNK3Ey?=
 =?utf-8?B?dWVFZyt5Tzk0RHRsN0JLUGZ0VXVFWXg4OGdZUnRobys1UFpuT2doV1l4Tk14?=
 =?utf-8?B?cGJXWm03RXl6NE94Yk5XaGlnemp2bWR3WGRoZjQrMnZ6ZmlTWWM5aXhwa25O?=
 =?utf-8?B?bUFRQWo5T1B5V0pFbVRtLzJqTElVS0VITDRndy9WN2I5a0RCVkRRd3ZtSS9y?=
 =?utf-8?B?RVZPcEROT3BSWVBjVkRzd3E0cEpFUTJtdldtbS9Zcmc5a0YreWFYMEh2TjNo?=
 =?utf-8?B?M0tuQUZiTWZTWUJwY0U5ZitqUzBmZXVFaWh4SkE0UTExRmdQZ2wvNmJuYzUr?=
 =?utf-8?B?R0VaSjcrTnFFRHpwZmN0UVNJRnJ6YlBFcXNwQVh5VEJZSVBmeGp0LzlJS2F3?=
 =?utf-8?B?NHZzYlRZOUFRdWNXYW1Pb2IwaEdYOTM0dHlmdWc0cUtpR2pnbEJhYmk5ZkZO?=
 =?utf-8?B?VVFnVitkK0J4ZzFLdkhsT0RRaVVpaDdSMWFRam5weVZKU2VsSGdPckNYdnNy?=
 =?utf-8?B?eS85TTdLZzRFY0hDMHFtNEFLZVN6aGFQNzJJTzBkV0FJVCtLamhWVE1pT3o3?=
 =?utf-8?B?N0tzOU10MnFtMkYrU0FZQWpZa3pldHdiRHBBRTRhcVhuN2xZelU0dnBXUk5C?=
 =?utf-8?B?a1lpYlYwampEcmVwdnRPa2dTNTBIRzhUTkJ5VEwvN1UwRFJEbnMyUVB6Z3RS?=
 =?utf-8?B?eFpyWGZoWEp1dVFYVnVBbTJaWUxWTm5rMnhwOEh0eUordU8yeUY0VGs4UW9W?=
 =?utf-8?B?SHJCQkQ0SXhEN0doNFk1S2FwcmQwcWNFWEJ2Y1BNbUpxRHJoQVdJNHFsYXlq?=
 =?utf-8?B?OXE4ZFRoaGNrZzZ4N0FFYlhQOVI3NlZLbmljVlpaQmpyVDYyNXBqMS9UQ1ly?=
 =?utf-8?B?ekZPd001VVA2VzFkaUxSQ0JvczhiWDlqbVl4MUJrWm1lbVdoNzRnSTFLckUy?=
 =?utf-8?B?cUcwVVlKZVdBMThQaDU1SDFMSS9sVkt4N016RXNTWGdLSFJJbUsrK29rRzRV?=
 =?utf-8?B?d0JreXFvcWRiNlkvMFAxUU1rL0FtQm5IczFnVStkTklVV25DMGtlem9IbXI3?=
 =?utf-8?B?eDR4RzdiSWl6SFBxeXRHUTJYQU1JcmdsYzhhTGdoNmQ2Z2luUEJWSzNlK1Nq?=
 =?utf-8?B?akRycGVXZ29qZy83VUNnSVZIOVJ5OEo2K3d1RGJQWFIrYnhOWktqSWNIdVov?=
 =?utf-8?B?VlNmUytlOCtJVkJFbzBvZEorQnBsbk1oSzZYNllzaWpCL3A4QTlnci9ZV3dw?=
 =?utf-8?B?SU5lZHFsSGM4ZUpUejdBaFg0eDZ2RU91ZnlQNzJ4M1BGd0huV2lqS3pKMVRx?=
 =?utf-8?B?NE41TkJuMDdQUFdVWUZMRVlIT01SYTRXZXFnL0l2WUtVdEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1AzVWdkTE9uYzFVYXNEaVA4eWhMU2o5Z0oramNpVUtYUHM4ZmkrT1AvcVpL?=
 =?utf-8?B?WTJDMTZvb2FOM2pwT3k2MjFPeDZreTl0TXd6QXlMc0NiTCtCUmJpcFhyZ2tp?=
 =?utf-8?B?RmZTZ1hDOWMvSzZmMHFpL3YyQ1dXQTcyQnlLaEhaU1FKbGdOUmZ6VTdoVXhQ?=
 =?utf-8?B?UWUvejVFV2FEMUhrUE1zVlJndmVseGs4cnJXczJJVzdMUHFXWEtJV3o5dk5G?=
 =?utf-8?B?d1cvWTFXZW5aS3VLTHFVS1BNWndxK0tFaXRxN0hxUlBWYXR1MndVb3p1UUN6?=
 =?utf-8?B?anN4NmEwakI5M2xBZ04yaE1oY2x0ZmdIVTBsbXBxYm8zcE5qbVRMdFRDUGYw?=
 =?utf-8?B?M1BrU0w1M2kyQkp5STNEY1dBdkU4alVxbG0wK3pKSWpHYzVrOGlBeVZKaVo3?=
 =?utf-8?B?SUtYN3lqdUwzSitTQ1J2T0l5U09MdXBIWE5leFE3K0E0dlJYaGk1a1FMNXho?=
 =?utf-8?B?aGFNekRRZzRWdTRzRk9leHZSRkEwUkZWbzc4TXN5dHErVUtVRDQzTVQ4STRR?=
 =?utf-8?B?YUxQUy8vOC9yTWdOZkE3aVdBRGVzRnhYQzhoQVpQZFE1MW1mTHNlbWlFWnBM?=
 =?utf-8?B?VjhUeTF0VlNIcVk3TGx1VGRWM2phQmtOaHlrVDdOeVFEY1p0S1FaaE9nT3dM?=
 =?utf-8?B?MFFkNkNyTVdxQko1QWFWSUlhU0FMZC9yNFdMNThqOXA0MGM4bFZGQkNrQkJD?=
 =?utf-8?B?WnJYN3E5SVpzcSt1Z3NQeDFzWjFZWE0vSHpUdkV0dnJselRoZ0thMTNITGR6?=
 =?utf-8?B?RWFqbkVLakhibkw1QmtyQkNlYnVkODNJYUIxTjcwZTZsMlROU2NUdUE1d2wv?=
 =?utf-8?B?aG9YbVdqd0hZMk9adnJZNldrTFo4WlArYnRyOVE1MHlTRFI0YjlHQVErcFNw?=
 =?utf-8?B?bmNYYVNrQ1FUaU9uS2pyZU4xeDBtb29EZ0RJcUVzRnlPTHJJOFJ1ODc2SDVt?=
 =?utf-8?B?SDY0dVdkbnJTU1JIYTVISWRKMjRuVDNvSXcwL2dDQk9aQkJadmEySmFyZWoy?=
 =?utf-8?B?aHdoTmxwL2k5b1pnSytweWFvSisxNHBFWWR6blJsdTE1K0NTWlU4VFBUSkxv?=
 =?utf-8?B?SkZNWVJoK25hV0JvcDA1RlRCaitodW9lblpJZndJRHJ3TjE0dWNoaHJ2RlI2?=
 =?utf-8?B?R1ZtRDlZRGF4ei95WHNLcW1JVkdUcHU3aURkcjNmL0VHMGRkdkxNVVBaVVBo?=
 =?utf-8?B?MGRDQkpmSlB6bDBpcUxRdGZieXZ0RzFDeVg2bVB1cnd5WVdPMS9leCtVeWdr?=
 =?utf-8?B?NkdnSnNLUVRLS0NmdkJpVzlhRTByWGhoMjE1K053Z24vOHpNWkhidFRlZVVr?=
 =?utf-8?B?OEhWS29FWU5TbVM5aHRtMEVUdW5HcnRUNkltTm9xVzU4NnF3Kzd4cTJ4dlp3?=
 =?utf-8?B?amx4eElqeEhselIzcis2eC81QjJFSHRmbGh4UU1JdXI1djhyZHY2Ylk4RG9K?=
 =?utf-8?B?QnVhSHB3eFVjUFhmclRiYUtYOUJZZE9LQUUzajU4RzgzZTd5dXA0ajBHTHc3?=
 =?utf-8?B?K0o3YlZOQXdZSzlhUkE4SFFRUFVJQkVwNldhK2p1ZnFNR2RJZFF6QVRDeGxU?=
 =?utf-8?B?eHRTM1pDZXAwc3U4VzZ0ZWRRd2I3cC9Gci9ubFdCZmlFYTgzT3NkQktCbFZi?=
 =?utf-8?B?N3I2a00reGNRM0Y4dk1CK0RhVFhJdjZOMW14dGtiRG56dXkreDZpTWZEMzFT?=
 =?utf-8?B?dkluRnRYc0pPZ2tBS3lPbEErYU0yOFdQMlN5ZnpkV05sNTBTV25VTnhVajNq?=
 =?utf-8?B?YU91djlFVi8yOXk0VkFVbXdZZW90MVhlbjZUaTA3UzZTaXcxRjc0VitKU1Jr?=
 =?utf-8?B?WWFWcmhlSlNKT3ozR2xOSHVWdlJNRDEzR0NCL015cGNKNVY0Z05oVlpjYWti?=
 =?utf-8?B?dDhKVjF3U3pkQmc5Mkp2YkVVNi9EZXo3T1pKODgxVXAxcGFkV00xbWhhVm95?=
 =?utf-8?B?NnR4ZFE4ano5UkFkUnV3VHY4a3ZncjBYQlVtSGdtQXNjMm5MSUk0VmpDaENO?=
 =?utf-8?B?U2FBM1l1d1Y5WmErVXFuRGdLU28xbTFIVCtlL3FGVFZINlRLbnZmbk00a1pG?=
 =?utf-8?B?ZVMraFlPV1BNQzRmbWdLTklaRmdOTnpEbFg2VjJ0dW1GRWJwOUFtZ2RiKzVj?=
 =?utf-8?Q?fCys=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb2b2cb-0352-47a8-333d-08dca514f801
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 21:27:45.9482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D8PwmSmwqyKbzCuUdUqMU3qP4H+dfRict6CDBgI6bRicLHBE5ro25ODJ1vEhaNk8MRoErM3Q5bYdHlw5yFPXIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8275

From: Haibo Chen <haibo.chen@nxp.com>

The flexcan in iMX95 is not compatible with imx93 because wakeup method is
difference. Make fsl,imx95-flexcan not fallback to fsl,imx93-flexcan.

Reviewed-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
index b6c92684c5e29..c08bd78e3367e 100644
--- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
+++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - fsl,imx95-flexcan
           - fsl,imx93-flexcan
           - fsl,imx8qm-flexcan
           - fsl,imx8mp-flexcan
@@ -39,9 +40,6 @@ properties:
               - fsl,imx6ul-flexcan
               - fsl,imx6sx-flexcan
           - const: fsl,imx6q-flexcan
-      - items:
-          - const: fsl,imx95-flexcan
-          - const: fsl,imx93-flexcan
       - items:
           - enum:
               - fsl,ls1028ar1-flexcan

-- 
2.34.1


