Return-Path: <linux-can+bounces-7387-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PRdNW9R52lW6QEAu9opvQ
	(envelope-from <linux-can+bounces-7387-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 21 Apr 2026 12:29:03 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D48439864
	for <lists+linux-can@lfdr.de>; Tue, 21 Apr 2026 12:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D32F430347BB
	for <lists+linux-can@lfdr.de>; Tue, 21 Apr 2026 10:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07A13BC691;
	Tue, 21 Apr 2026 10:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DC5hRliJ"
X-Original-To: linux-can@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013047.outbound.protection.outlook.com [40.107.159.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5163BB9EF;
	Tue, 21 Apr 2026 10:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776767185; cv=fail; b=JreMBMwUFn4dpX1zakZpGKnMqxRyJ4lWJCyLqOmcfj9PVE8/Ph9thDPnokmwarAaRZCH+c/bS5nWjjDKir7/oflBCm5lry5HexdJULDWy7i05qY07Nf4OfmnNslGPuDXJ/LBdkKXJt7EwiYDNUEIXrsJEoFRAXfzLTYaeeqHxgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776767185; c=relaxed/simple;
	bh=dvqlA/+PsJJlEzncLWa+oyUQ9lH5CrO9L1+Eu35xP4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uZEZW+4IA6+PGB5pWuzI4OaydXz1ZnM2wJzZdHN8RZBA9gJEmNdWg3ok0f/7rduQ4qdZF/nwB33jFayDaZbQjFU6mARizg/m54AzSJNPAuuCDHh0exDexy4YNRBPnurHk0WvkK1SMHCfyhFbFHerCUarNa6VEN4rqVwOTunvO8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=DC5hRliJ; arc=fail smtp.client-ip=40.107.159.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rn5aGfgK/E5+0zn8ThXO8BHLZYmqgbhn79TRXdw1vol8ZrSvZsGEib5u/Pp5vrVxrfqlbS+ER5BSY+W6WZibEWvSUp+mUdY8AAl8885HV8uz/7YV0eRnnmtszIaFkQ776CEfzmYhL+/Hq76acv+lBt2c41Ag4hd9OfbsxDlaepqGMYzl7U8gHUtEegBn0c/t/T4TJDPrdRMoujDA5Ok1Fls0qnRSd0NdEIeKJSTjALKUifYZLwwaYcF8IG37WvPKISd5CkXAyU6rZvWBaTUbZAGv7Q4t5/fxqzOiLKcSZP+rkn5hnXA4t6Ffj4HD3sVrgXtIOhxVhfgOAH6/7ilA9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DuI02eGgTMohLDcKqbUKOD9e9B5e6+jwjve8/2Av1iA=;
 b=O6xUWzGYekA0TNj2yYW920wwZ5I1mr8aQJ3pgW8jxGpZRD1OIFUV0HnMriB4t202z2O1t9mqdXmLGWqCVp5AU61tcFlm6pAbvIgQIyNj5Wx7Z0FZPqYNLw6fMEPVNDeDo4jKmQzAq4BbELRj9hK3+T5XBQlX1dlRFjxkWWJn0OT8HTfm869AI19Fi99NtPIILqcaFXVkWFMt133BJyGBokJmverJNyEHJQMBzJb/gDvcinSR8M5KkhKliGollTH7qOzi52ojX2gnd6Ruw4Mev+5r7KNmVtD5ky9LF0YbD5G5+v4K99RtQ50fieawuKv3afXWG5tmmsbw3AtIqiqJPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DuI02eGgTMohLDcKqbUKOD9e9B5e6+jwjve8/2Av1iA=;
 b=DC5hRliJUlIktWZg8y4lhjDimbDmbPw41N0Ars+9UFqM3V8BXlfEazQxD9gjDxu8PFH2+wcP07sF+ydYGmduK21h/5CQm42M1nUlEpIuaByPO08GjPAlvOuZB7rAcbjWjmk8CvNut5mzEpNS0oJApESOcT+HE5x4mHodQC72j/UcNIv2I8tEAO9BGJgNJns282jSupx20xWnMOeIMZ7KMi+MA/5K37xx0kGYPLvT4JemAOAa+ICGzGOk0bF7DzUIyKNtaS9YAQPapl69pyaYrYeQ2K5L18eSpm7VHiWGS6d7QhRm4Jiupoip0XV+WdULTUSAsE0iHIarot7sZpm2sQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by GVXPR04MB10111.eurprd04.prod.outlook.com (2603:10a6:150:1b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 10:26:14 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 10:26:14 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	NXP S32 Linux Team <s32@nxp.com>,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	Andra-Teodora Ilie <andra.ilie@nxp.com>,
	Larisa Grigore <larisa.grigore@nxp.com>
Subject: [PATCH RESEND v4 6/8] can: flexcan: add NXP S32N79 SoC support
Date: Tue, 21 Apr 2026 12:26:01 +0200
Message-ID: <20260421102603.4122332-7-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421102603.4122332-1-ciprianmarian.costea@oss.nxp.com>
References: <20260421102603.4122332-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0039.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::12) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|GVXPR04MB10111:EE_
X-MS-Office365-Filtering-Correlation-Id: f459f286-0788-4b2c-f1b1-08de9f906a6b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|19092799006|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 TfLt86s7FYlRZbmvmGI4iEPoyNV+8biIYKD9F414EYKnxlaul/Dc/LwPIQztOktL5NT2/Ddo56p/OUEHGv1k75PeAvawWlsQVWpn63WcrJsRPctFd4H/wQJYdFsF1P8MNyvO/I6VOs+HciDtR5VS3PDvatEQJQMjcGjQCMa2ztwi2U8oynHzbHFp5YFgYY8HcAgL/bxv7qxd8p7HYYBIEtfWmsn5tVocLRoqenmmGWVxyItGXJqGdtQNWSCAEJx6ljbnj6W80SUmuelloLRpNfIcETmsEsiVE8P62INJUHJHl9IrpsjNueg/xuSzjvMfmzpmDhXKcvTQYSxb+WmQ60rQ6+m8HC8Vws8/t4I4Wk4D+3qskCQ/e9PTiJZzX/kCqJvLJQpeaufPqKlYgDEeSpmlgZfUR71VFFtgLfzr3SEaTfu8PcYYsa+5P6qbRUATCseoiIo6sQqrXPsATCmXYmStCixfCa6H4u/Ai8B2/PyBOw2uKfOPKrfggt+DOvtlhgCRT6JSsOkzOfoeQxRYlXLjczBA9NLgtVhYtd6RRlvYZ306YKe1EXvpCoBOavKK5d74xAHHFCvjYyNzBarU3KHgO19KAfIYAj4woHRV5vU3LBV+NWqgkrWKwhRsPMt+BreApZ6x/OIbv0Ps/XzyVC0EsHWUo02DzoXFuBPSo49I6F+6gA1nfVVDcTDWVwIQJYyfnTjvRk7SURacF7ZXFoTwvwreJnAFd7Jnk6OSEwY=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(366016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?anh6SkRlWXRIbURnVGdQNGRmUFFWVXNqNStRdFF4Y2VGSjVQWitvazNmb3ZB?=
 =?utf-8?B?Y2UveVJ6d0RNQVNDalhQblZvWFhHcVpUMUp2NzJ4bnBucVFJbGZhMGI3NUFI?=
 =?utf-8?B?eUxuYmRqUzNNL09maDdMdy80aWdIM1RPMHMwZSsvbUFmQUNkYnJLdm9qaWVO?=
 =?utf-8?B?eHBmWnRwUUc3TENSWTdTa2xWcmZ6ZnBQaWMvTGRtK283eENFemhNMEVNVzFO?=
 =?utf-8?B?UnFZamlLWVMrWDRwdFRIUTZ5dlhWbGxXSndlSElwR1pBaXJ1VGwxRmdiVzU3?=
 =?utf-8?B?WkVaR29JemNWQ2duTkFFemg3SEg1dkFjOHpsVlQ2MFljOUEwRStuem9YMXB6?=
 =?utf-8?B?Mzc3M0VUV3E0YVdsTnRnS0VvY0Ftanc5RjNGelplWGtoWjU1Z3VkVTUzT2V2?=
 =?utf-8?B?UVNINzFSOWFzUVpMVnJFK2V6ZG5VZTlNOUpCOStjTk4yRE1JSWpSSy9tY0sv?=
 =?utf-8?B?aUdIMUVvWHBaSTdxNlRvLzA2OEt5NmtXZGZYSisrdjdBaUtVRlBYRloxaW10?=
 =?utf-8?B?V1h2SldpWnphWTlZY1BLcU9WcEx6R1hMSDlhYkhXUUc4VEFGN0JndkIyczF6?=
 =?utf-8?B?dUlvYWwwckRRVzh2eHl0NG9GQmVhYUVPRC9ieGpBQ2EyRWYyY2lXVDNNZXhh?=
 =?utf-8?B?R0VQQUhwVkczU3dCN25CR0tUMm5uQXV3Ly9kK290aXNWdG5ucFNIdlZDTmI0?=
 =?utf-8?B?MS9VNDFXTkl6WXI5cEU1TUc3am81TnhGRHRabGdvV3hrcnFWcVpCMnQyeEth?=
 =?utf-8?B?VVRhTG90N2F1dEZJTlFmWGhMVWRwS05HN0hiazNUclRmVmRQSkRuV0dJQlR6?=
 =?utf-8?B?a2pZTTZSTW82M053QW5uOEc3Zi95WWVTOUtYOENFdlk3NW1FcElvL0liMGlM?=
 =?utf-8?B?OEtBdzNqMGl2b080ZkFCRXlDV0JDaDJnOWJjWjFienZqWEVpVERpRTRadGFo?=
 =?utf-8?B?QTJmZGIrNE41eDBBWTE4cEZoZFFaczNncWVHR3d5b2Z1MHkyWHcvOWx3aE9Q?=
 =?utf-8?B?dU1aZGhPbUxrTjlodHpnSjNmK1E4bjBiY3RxNTZsRlJ0VzBHbHh3N0U2OFNn?=
 =?utf-8?B?NDc3Q1B6aE1CZW9Ua1FkTk93andURDVsYnYxK0RtMFVvNlAvNnhzWFZHSE8y?=
 =?utf-8?B?WEZ6bnUrOXljbmdWaGM0NDJCVXhMdlVwOGpCNVoxV1NVRmxuZTc0d3ZqdWkz?=
 =?utf-8?B?cHNDYWtKTDVTOVdWZ0kvb2hQcCttWmpSck1JbnIreCtuR1EvZ3lXMmxIQVRy?=
 =?utf-8?B?S0ZBZU5sT3B6ZXJCV0Y2ZjZZVnlYOTFSTjVoR21IbHQ5ZXZJSWJzMW5kQmJ4?=
 =?utf-8?B?NWE4UjVXUWY1V1F1M2dIUjRkdHV6bnFTNmpCNzA3YzQwd2ZHVUJzZjFTQTUy?=
 =?utf-8?B?cHI4MzE2aklCczlCTGF3UnlPU1FEaDR3UXpYWmRUM2FWTTJJZGFXeVJiWE1a?=
 =?utf-8?B?NkJWZklVMUphSEV4a2JIQlQzaDJ4MlFmOTdkVmY3VnZSM2l4QzQ2dVJOMkFO?=
 =?utf-8?B?NytYOVFIQm4ydTZ1SThicnZ4MGhjaFFJREZYTEZoLzgyQlpSWW1VdFg2U2Ny?=
 =?utf-8?B?cE14czdBWTVKR0ZadjN2TUVra0MxUXlrTWN5a0FDWU1MSUYxRzk4bi9GMFJx?=
 =?utf-8?B?bXBheFVNL2hDdDFWY2owclJjSXg1TGR1U2NBOE91MVBibWNtREVhSWFlTjY5?=
 =?utf-8?B?aXM1RzlUZkd0aXgxbUdDaTQ4NXhaYlFnSUZ3SHhyQzRiTSszRmdCcEw4U0s0?=
 =?utf-8?B?cG1IODJGS2hINzl3Y25NLzVra0l5ajlnOSt4UDBGSFdQdmxyTU5DZmQvTFVu?=
 =?utf-8?B?dHNXdXNYUGNTZDM4SGxzRHVuTyswaGt1VENMTVFJaW1uTi94Zk1UTzBBeW1N?=
 =?utf-8?B?QnU0bEhHbUFhcTdIdmNnOExYem9uV3lRdEdwZmwwRytCcVZFUzJHR3ZJZCtx?=
 =?utf-8?B?cHpOZEtXQ1JkMzFxL0xYVzF3L2dBendJMllVKzFCcEc1akhjR3VmNXBLLzV5?=
 =?utf-8?B?SE50K0xRaE1RUklBOVpMOXRhdUJ3am1pa1FLdWVBOXIwN3JuNHdOQWhDTWgw?=
 =?utf-8?B?OUkwNENsY3FqOWV6dXNTUlg5RHRtUFBaVWFUODk1VzZ4VHp3WXV3NlJWdFpW?=
 =?utf-8?B?N3JLS1Vzb3FxYVJnVUtsd1NhUFBUYnErcVYyY3V2MzhXaElBcDA5OFBjbEl1?=
 =?utf-8?B?ZGJSTWltR0V3eEdJRkI1Tjd3UHRWeXluRlB5K1piZ1hQUC83S2NCeGkvZlJs?=
 =?utf-8?B?dXIwQkUyUkdPRWRQaGNNWXB6ZHlsWWE2UklUaSt1c0xSdnFBZXJaWlZRbkNY?=
 =?utf-8?B?N1FWcmNrVnNlalU1UTZSb2pYUXNaSUFESjM1cElxSXpqTnREZm8rU1I3Y3pm?=
 =?utf-8?Q?6NjtbtGi5LYzL6eY=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f459f286-0788-4b2c-f1b1-08de9f906a6b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 10:26:14.4308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /R1sZgNFJRipnRKewirjoAj2Qt29p/RzuFdKSYkiM+AaJEu+xeEiqEaQTi6JuA5GRwb09Rt+Y6JbWsXLnw7pL9rJnwCIyd1Stg5MFBcYL5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10111
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7387-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,nxp.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.nxp.com:mid]
X-Rspamd-Queue-Id: 52D48439864
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add device data and compatible string for NXP S32N79 SoC.

FlexCAN IP integration on S32N79 SoC uses two interrupts:
- one for mailboxes 0-127
- one for signaling bus errors and device state changes

Co-developed-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Signed-off-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index 23ddf7910641..9ae0d9eb4ccc 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -397,6 +397,15 @@ static const struct flexcan_devtype_data nxp_s32g2_devtype_data = {
 		FLEXCAN_QUIRK_SECONDARY_MB_IRQ,
 };
 
+static const struct flexcan_devtype_data nxp_s32n_devtype_data = {
+	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
+		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_RX_MAILBOX |
+		FLEXCAN_QUIRK_BROKEN_PERR_STATE | FLEXCAN_QUIRK_SUPPORT_FD |
+		FLEXCAN_QUIRK_SUPPORT_ECC | FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR |
+		FLEXCAN_QUIRK_IRQ_BERR,
+};
+
 static const struct can_bittiming_const flexcan_bittiming_const = {
 	.name = DRV_NAME,
 	.tseg1_min = 4,
@@ -2232,6 +2241,7 @@ static const struct of_device_id flexcan_of_match[] = {
 	{ .compatible = "fsl,ls1021ar2-flexcan", .data = &fsl_ls1021a_r2_devtype_data, },
 	{ .compatible = "fsl,lx2160ar1-flexcan", .data = &fsl_lx2160a_r1_devtype_data, },
 	{ .compatible = "nxp,s32g2-flexcan", .data = &nxp_s32g2_devtype_data, },
+	{ .compatible = "nxp,s32n79-flexcan", .data = &nxp_s32n_devtype_data, },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, flexcan_of_match);
-- 
2.43.0


