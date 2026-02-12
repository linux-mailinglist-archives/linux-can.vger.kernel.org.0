Return-Path: <linux-can+bounces-6543-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPudFXkAjmm0+AAAu9opvQ
	(envelope-from <linux-can+bounces-6543-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 12 Feb 2026 17:31:53 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C042712F751
	for <lists+linux-can@lfdr.de>; Thu, 12 Feb 2026 17:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 87B27305CE3F
	for <lists+linux-can@lfdr.de>; Thu, 12 Feb 2026 16:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C04D35D611;
	Thu, 12 Feb 2026 16:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TIn/IH2t"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011029.outbound.protection.outlook.com [52.101.65.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC0735D5F3;
	Thu, 12 Feb 2026 16:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770913823; cv=fail; b=Rq3O7w5t3LJUxAgpqlAnC9s591jNsetXO8nXUjN6QneDbUYFdSloeR4498xM3oLDrGHyo5ReNAtWhR8DQcMio5tz6vGk8MP/2CpfWQUFsZG+djmsBiESKOJyNVQ8vFH2AZ+ybNEAcJePRKfCPJx1r7KLvuTFUFBgsn3/XlrbUhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770913823; c=relaxed/simple;
	bh=zizZkjHrezHds8eJb8JdQZRvg+FA+QlCyZAT7Y1S8Go=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=O5PjfAYitYhwu3rWO9C/oQeD5V906N/9CsTQKGHnuDzdVJBX/DDEeKjNlZagoxwS9iWH161e5xIFFUGej3KQWNs3lxT39mSJeLtLTBwhUANDPnMURrJVHrI6tQocX6Y2rzlctgSV6dVeIEfR84gMU0mVartnQr4fc0++NF241wY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TIn/IH2t; arc=fail smtp.client-ip=52.101.65.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jbW6kiRuyDTNgAlJjtw8/ccN9QILonjVdppYs9bPVh9k0SUsfcXseywYMTbE3zbvJe+NtcrjQCAy0Iv7Pzl/sYG941SV6jpNwRq52nKp3XdCGRGlJiug3Cy6SS155jHGdfVlBdZ+12bVPkkjEn864+0+8JPA0+2X6wn/CQPizMP2AxaluAu2BLOsD841h0Dk5vdT3V6NgCovDozZYOrB2YuRdFKN2ioqqype3km1nfQ9UPBG+gu+rZpVbKRQW/FsmhRZ86fGU/XzartkZBD0RvfBCq/ONqJ9kxhplLRIeg3FHCYDb6nzFUEsyZRPRTBimYdTcTI+4ZCGL5KzXpQqGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRDF5rTKVKwM9e2R10oyLi7Nycj9leexapSqsgatLbg=;
 b=FEgV4u5VUcbb+0nuU8CuSUI/4zH6Rv78EQvxlA79f8gdrLhYg4JPO4IUiIIUcnWqJUbk7LeoCsQ1alfbOCL4Z4WRJaMHDtPaiBMZX/ASJ+IimavRmMIoIhnnf2cQLolX1DkoUzJW/4490HuEgQLT6WYVu2mMrcvL5qw/hfxZD011sTeOZQEWyaKgjCE/x906VsX0zTj+zox82FrU/6SW1ExQcSVX+m+a0zHwzYsudFqt6nbJPxHtYZQIzy8DUP5iXc65uWKZ0yJBi3wNJuKNOigLK69MlA4A2kc6wggpD/dWKi+pBMj07tMNd3Ff5s/ekPWfXzpwgEPp2LLXxheo0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRDF5rTKVKwM9e2R10oyLi7Nycj9leexapSqsgatLbg=;
 b=TIn/IH2tgIUr/TJZFkghWsjrRfKJvThw6ZZ0P9JqxD8Th3prLYdnK5DISjXm1KWBDAWLYGOi0dSRaCFNyoR8PUXxq/6aEFIUrgdVlaYFa0yu+LJEVnJkzehmIMFHZkk/lBSbrY96+Sp1Tz+4tZy9YhkkifTYcY6SpaXh0V86oRPWVO9/SHNYiGQb4qgT5WaRKIsU6dpOlzYL4OoRshxsbroMLILqqQSIvr2IaEM71eVD2ujF8RjACIV1OtzeUhNbb19vt0piW1OUKyxO48t5gd/Tc92snAmtHdaoDSI2uCFjs4DMzmjtA8GRIs0qdFc/K6N1NFreLTVAzp0ccXXbdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AS1PR04MB9310.eurprd04.prod.outlook.com (2603:10a6:20b:4de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 12 Feb
 2026 16:30:16 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Thu, 12 Feb 2026
 16:30:16 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Wolfgang Grandegger <wg@grandegger.com>,
	linux-can@vger.kernel.org (open list:CAN NETWORK DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 1/1] dt-bindings: net: can: nxp,sja1000: add reference to mc-peripheral-props.yaml
Date: Thu, 12 Feb 2026 11:30:00 -0500
Message-ID: <20260212163000.1195586-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR21CA0021.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::15) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AS1PR04MB9310:EE_
X-MS-Office365-Filtering-Correlation-Id: b5e209a9-59a7-42be-5c90-08de6a540111
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5Y/e+G9DEfsNU6jLdSFP3MeRjXsND0cfZuTB3yeS3GtfDUckfgrzROx5T/xj?=
 =?us-ascii?Q?ysfyZYEy9i3MNr2cLp0neaC/LdMoyh8oi0eGZugA81moAW8+eD2BLxsOQduj?=
 =?us-ascii?Q?pOWmBwGrJeL+IHepGjZzd1P9MJ3IrC3JiXfXYeylJ7jo2sGy3at1HIJBBu9k?=
 =?us-ascii?Q?ViVpowDRRCqHSVQWG44X7IjXc/khHBKZ5eKIlZDbcWlrOnSVrrlz6OvNGggS?=
 =?us-ascii?Q?bH/r7+3AxyJJoDTO46D+jQtSW9bAfPaOBYYcKRrrxAim9wZid8s3BytSCTJz?=
 =?us-ascii?Q?xw+9NJH8IO0bq84gq2hUjgVW6fqPB5JZ3vyWy2K8frtglJLCdEQjI/Z3vygY?=
 =?us-ascii?Q?X7TgjR6UiAXBJImohxdx1zi5FQqsYNEGzWlNm6f3HCeCA3QsKnCjAbNWyn6U?=
 =?us-ascii?Q?YS1OTu8Nh9s74yuV7F4cIQXYcpm5QzNGcJg2V7LStCuMDuNtexHAQU5ZySRo?=
 =?us-ascii?Q?iaV8GPPLXNoFpIkAFduFEdnz6rJBkGiOFxBA4oD92yrFblDvDEAAm1FRFugf?=
 =?us-ascii?Q?u1U1KPNK0f/DdJH5wlAKTd8BuKUKtaQA/JjU+tBRXLLAnAKUFDRi4FriEOyD?=
 =?us-ascii?Q?Ecr+/r8S2gxgfmYiHPEjAM0bMiouY+aazRdRw3O4M+KhdVvQ6UERMiqHBlrR?=
 =?us-ascii?Q?wgYAaz2O1DoCZDh2mINatOyVUyQxkpnLCEDrOU8cpUJ6wxs2ZgoYAVPTHsWF?=
 =?us-ascii?Q?H62vtFi+zQ2PZfcKZJDaBD3J1h/1NWWrlJ3SNTC5M1ahJj9Ko+3l/jnuGA+m?=
 =?us-ascii?Q?jFXeyT+1BaFaC0s7+bxUoJdDVUQbiwCfgQTd16DaLKGfP3MQmCFaglzl/CiN?=
 =?us-ascii?Q?1bVG2MIYcvJNbjo5s0hMcpnbrgDeeWSYx6RRx82Ex7o27lWNkndFvHiGOKnj?=
 =?us-ascii?Q?kWjCXy+vdTQlODuOF25k4DVsAKWN2X9AdQtbEjmocFU0sw1eV0ShLzQGQCA9?=
 =?us-ascii?Q?ullrVfLW9mJkSk9wZ8qPejAorx0DJMZP3jSYaQC6Ntzt2ADQDAIIYZ613vne?=
 =?us-ascii?Q?07UBtOr+G1bM7Y0NOKqe7cTEeSfaT/NmgoCRnWuRHnTANEDiltT86heYAu+d?=
 =?us-ascii?Q?vB/vHjc9ZaREYDl5uTctbn1S6rDnRoEOgg2ePB9rXXVdttY5cUkoByc45sUa?=
 =?us-ascii?Q?zUoarNQmV8WWxfJLYPw94zQw5KxTc0JEk6dV3bDmVAvUzOlN4fxuF93Cs9+o?=
 =?us-ascii?Q?YnGYh6J1JSEj0lha8PUL+eckKIuPNrZrDyrqTTKS31R1nFW9WDnHRjV38Fnh?=
 =?us-ascii?Q?6p0EeBW3WCUrx5iALpjsB1yESJbOGVgYmWDrW0V7TpDJC7hzzScBkz1/2Yfs?=
 =?us-ascii?Q?dKaHJXMynylIH9v9PyWlNuDp/ho/XEuZ62rmiu0wF+HYVFgyLDgbnWn+hOpa?=
 =?us-ascii?Q?V9b4Mpa6Kh5ObxyBwm3tVtoa+l+adBAZh4nUPBHK4ldPDw6Ens+TFYR+5l1A?=
 =?us-ascii?Q?DD8+1BAMVhQBOCliwCGWStZ+oURphsVx4BtiHFDY9LFXAxAEqkDLuo334P+b?=
 =?us-ascii?Q?LIdHqlz7cwEH1MxGgkcS4Ul8DuTKPQlUnXG/8pSvcGf3k0H5kPUuHgzHqM8h?=
 =?us-ascii?Q?QIZaVEFzcegNRLpK7ZUoZ06m4WRL3ViljV21Kp6TW8Ajf53gQaoeC7ia6snr?=
 =?us-ascii?Q?aP2zy2euhMvDsSemJn0aCb4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CLI+9gxgcAz0IzSc94X8+Loa9wKM99AdTY5OZvgRy2r0hT1Zpkl8kwBiEhFA?=
 =?us-ascii?Q?LxswzI6JLT4GGcVmyeATzrxeYJ02Nb1xYlJ4uoayG4AMIdFWLCv2YBzXrHcs?=
 =?us-ascii?Q?KEOiS/MxS4dN6oj8JKr53MIJu+E4AadyRkytSMKskvdD+F9IYKeRBPDJSrw0?=
 =?us-ascii?Q?aT7/XAjU0FWlDbf9F3j0NGCdrMnNXCW5Y+2+Ju2mbo+7BbggN6IpnjrxORD1?=
 =?us-ascii?Q?Dk4r9iHy3HE9alf1nc977Z9wrcTY3K/UsTvtbwfiHFrOTBOuGB4r+Ss5tBGd?=
 =?us-ascii?Q?IowyZhNGEpvOm+fcJapzKWvbBb33wSPriYzbErT5886A0cEibtAiCHi5+vGC?=
 =?us-ascii?Q?Uw+5SlSbDhvI0iVTztg8i2RAFwKyT85yHepqmlWTd4sWbIXuDqoN7um/xnyO?=
 =?us-ascii?Q?yy3JS/DehlrMBBO66vUJGU5sybgXMV/ZRYPK6/EgpZ4BNnTPGVElxHYFxlTW?=
 =?us-ascii?Q?1Szf/fnz/HmZZhT/JPNNerViUIJYUVEMLqNAEEEp31eWJnRFBmRqYY5U7Ppx?=
 =?us-ascii?Q?eVFuc5NVpudQ277d3c7WDKI8T0DtTWfkjY8fwgCbbmt7C5y48o8LSvyYNWJ5?=
 =?us-ascii?Q?1qK2orFpYq1/KrGNdFiIvVF5NLHU/HZ5Wubj8fpm5ewVqkWNLOFo44bXvqIz?=
 =?us-ascii?Q?0/aNjaesKEZj1mcXtk7mHFUuO6v/HI0iT6FkBiTyU1tvv4ujEnHFNME2Ojv5?=
 =?us-ascii?Q?RDLsnrl1Wrp3ZD67UT8II//VjLWO8ytnWXYc9iIpYPVOXIFsx90hVAhIY2kZ?=
 =?us-ascii?Q?z1lfuL6Mx33qebdBN4jhmO5Fq96z2cMGG+1NnjbiZC7Gng1MccjoZl7WPgAv?=
 =?us-ascii?Q?rQXZE17246rOVFAeiYCYDEkNeCgI0oxvAdTPvAOr9KCDcCuCm3yWXEUZhDOC?=
 =?us-ascii?Q?25JgjD8R3gQtYihiRmkRXwiuRVwNxIqL2BpEn8nk9dnaOcMW7oR44AaakJCB?=
 =?us-ascii?Q?ols9hYN1xTvleuzMFBaPw1ga7oB4siR8PDpDMSwQFEwAkL2qJbI0szsnpMqQ?=
 =?us-ascii?Q?tialq+pd8P86qJJD56aIVLSU9WxAzVCwmwGz7tovoX09YA3wRSexPZeRkVgC?=
 =?us-ascii?Q?005E/Prj2/mG8RCZn4c+SfmUd2mCTPcmIbK8wvvpr58xerhmwMIrJJt5xfyE?=
 =?us-ascii?Q?nZ7Lb+H6EK37VYazRYnlqbuwVRpqK4jX/T8QTqaJfX9NT15Wbc+Yu2u7kt8b?=
 =?us-ascii?Q?ileE+KYcG7E6OZyclQKlLFobcUaqFgVQA77T6VSnjN0fMRlHiJrCwd9HNl5t?=
 =?us-ascii?Q?3j0MX/yWfPwxpiwjJGDS7P4WnOzwyy1DAUbrn3JsyiltHRWSiHaF+JSuFvHp?=
 =?us-ascii?Q?gJDV4+gFjFaOOvQEztUlRICUVRGU2y274Ln9a7klrHSVYZSraN4xR4QWKkm1?=
 =?us-ascii?Q?29T+6eR/eTVA9HJosU2teJ8OKt3COxlQicc6U3M9HfLF0CweRUiN7GDvdF7z?=
 =?us-ascii?Q?zHC9YY1H5IgqGITpavv74JwX7SecJEcXK+VVXyZgqB5IPiMB8J4VIyJ6G3vX?=
 =?us-ascii?Q?NMQ15GfkaKpdpyE6Sb0sY/J8Ig/vX9R5IdnV3/2MS5GTdwKnVflZuUPULnVr?=
 =?us-ascii?Q?c9NaaNnwG1E6kTh7XWN9D4HJzmnqTmWdEdk8LoI0VuqJhA3ERkWEw3ZFMSLS?=
 =?us-ascii?Q?TByq/I/KvVW8Uefai1SSGadH+21w9vDucFPeS77UijSQRSJZ9eqgLTBNBD1w?=
 =?us-ascii?Q?YsSpHo7CKt9eGWBO6NkmVat3wKLAbo8fK0R1ElwFf3c68S9qhHwMclvroyNB?=
 =?us-ascii?Q?o9saE6sW4g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5e209a9-59a7-42be-5c90-08de6a540111
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 16:30:16.3813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XVpCWMYDW18GZGoldqlutJ8dNwZzzoRaCrC/uF/d/5zXmJbE6v1oPHR43MATGoj0GgHGNS23bekpRYaKxIxlNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9310
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-6543-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_PROHIBIT(0.00)[0.0.0.4:email];
	TAGGED_RCPT(0.00)[linux-can,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:mid,nxp.com:dkim,nxp.com:email,devicetree.org:url]
X-Rspamd-Queue-Id: C042712F751
X-Rspamd-Action: no action

Add a reference to mc-peripheral-props.yaml to allow vendor-specific
properties for memory access timings.

Fix below CHECK_DTBS warings:
arch/arm/boot/dts/nxp/imx/imx27-phytec-phycore-rdk.dtb: can@4,0 (nxp,sja1000): Unevaluated properties are not allowed ('fsl,weim-cs-timing' was unexpected)
        from schema $id: http://devicetree.org/schemas/net/can/nxp,sja1000.yaml

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v2
- ref to mc-peripheral-props.yaml.
---
 Documentation/devicetree/bindings/net/can/nxp,sja1000.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/can/nxp,sja1000.yaml b/Documentation/devicetree/bindings/net/can/nxp,sja1000.yaml
index ec0c2168e4b9e..6bcfff9701173 100644
--- a/Documentation/devicetree/bindings/net/can/nxp,sja1000.yaml
+++ b/Documentation/devicetree/bindings/net/can/nxp,sja1000.yaml
@@ -87,6 +87,7 @@ required:
 
 allOf:
   - $ref: can-controller.yaml#
+  - $ref: /schemas/memory-controllers/mc-peripheral-props.yaml
   - if:
       properties:
         compatible:
-- 
2.43.0


