Return-Path: <linux-can+bounces-7260-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMHCAq48xWn/8AQAu9opvQ
	(envelope-from <linux-can+bounces-7260-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 26 Mar 2026 15:03:26 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 208BA33678D
	for <lists+linux-can@lfdr.de>; Thu, 26 Mar 2026 15:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 63590308E12F
	for <lists+linux-can@lfdr.de>; Thu, 26 Mar 2026 13:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A805333745;
	Thu, 26 Mar 2026 13:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="F04fEC3E"
X-Original-To: linux-can@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013067.outbound.protection.outlook.com [40.107.162.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70F832F76D;
	Thu, 26 Mar 2026 13:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774533530; cv=fail; b=UsjFIN/e3+wZbMkHbrsVGO3NE454Fxukt5wE1b3vfi5Cb5hLvX4PSINYFSxMI2EJuArBfYpXZAmfi58vsb+ztG4su5kBx3AsLomofc3mEWGzp/BfjclTVYyxWcB8YmOg5D32CDrT2kOCZxjKese31hGCtIuLUFoxn43NjjY2RyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774533530; c=relaxed/simple;
	bh=AmkQXFLaAgioZXQr+kr0ifiAPUfa04f++MCQqAML8pA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uslCCtb+C0osAmpS2ZE4NbFu6qLTZ285yZsQCqweFrHaekOIEoqetOdNMRLGz9Ep8mpHsFjbubuWrHvwfZMjB4HGM1wW4b2+63pdlZFNEn1SZwAyXM2il8wgVmtP9zAVgmiyfMtStoUncBf0UgfTfhf5XR3ixgnq5t6zbKwRX9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=F04fEC3E; arc=fail smtp.client-ip=40.107.162.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mDHAvQx4HLhMSy9K1inYyu22Uiw3i05HjtmPQzEPXinrKZh01VpIfaj32AVlRvVyN/bFPUdYxjYEl1qni/FPpgGc99UIRlVPzWF6cEjd2ril6o3M0ywMgCDzBbJ5p/atZbUfEkFCNc4dGIYa7cBxkqXILSA1xFyFvtvvHEnsly/nKzq24rYNzJV4HuQMDz5Ag2ARB3ljXes4mBz1PkMK8ZaYHA2CqtMIDiiVOV2MHHbPJq1SzwyGJt7lsjDfdml6bdzawSE9NEuHkTSfZWQssyS8GZFDgfAuos8+ikMK3gaHJwuSZuKiZ2mYKUO7vJr1xt7L15n5Qcw1T/lCS5KzdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U12gOewEf6DEQLWhQ0GYz+ip2neAn9Tagkuag0OJu1A=;
 b=vh1cbI2MwqfY8Nq3W884c/WB3gtB+YS/dgpc09+aSVsMGqbq23JazRn2clv8/KOFF6ko05njd2olYzJuUWe7kdmjuZcKRZ5aOqlfMY+/cRQMagsSrvtyjBNYQYykbQTtm/BBDEz6GHXe7nddkaNhg7xN062QAe5QSqoYmQEk2kfCrb0+N6wWQNiGP8q2U6uGX/gFbESxOSG0/aBOxW+SWg6Fct8Ncs8c6asEO4XrAkvelicvKIpBuZKTxzrUf4hrqY6IxPcVzBejbEwidrC2u4u0DU8fQGi1MiYClLDbQOYysHVR5nubrnO1hqI63aukgrMidrtr/iTM1jekd27KaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U12gOewEf6DEQLWhQ0GYz+ip2neAn9Tagkuag0OJu1A=;
 b=F04fEC3EoNsBZ5P9ty+pLiQsCTK6l0yhodId4PGzFgWrXQww8IvBWqyRAffvOPO3grK/+yz89/0VEbVDF/1oqGmoInOIsHHH6VZ3eF7zUdgbp8H3wxqRJDZjakcmBniP1Gn4T+4xDc896riOYpzHZP1MYhOh9r/sBXQ4KcKCrc0LfUbL0klM2VszgwWVgqIRSA/26fdWh36TjxACI2yBxSTtX8nTPuUVPnPma7wDi2weBpEr77fMqwRXpTGBo1/12CwlDO85/n2Xz47C+DIFTs8m8IdXsD4Dz3WX+C35BxBdO3IUupdm9y8G3S6clPNYm7yilYauyyuNxDQa/W2ggA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PA1PR04MB11261.eurprd04.prod.outlook.com (2603:10a6:102:4eb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 13:58:39 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9745.022; Thu, 26 Mar 2026
 13:58:39 +0000
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
	Andra-Teodora Ilie <andra.ilie@nxp.com>
Subject: [PATCH v4 7/8] arm64: dts: s32n79: add FlexCAN nodes
Date: Thu, 26 Mar 2026 14:58:24 +0100
Message-ID: <20260326135825.3428856-8-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326135825.3428856-1-ciprianmarian.costea@oss.nxp.com>
References: <20260326135825.3428856-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P192CA0061.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:82::38) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|PA1PR04MB11261:EE_
X-MS-Office365-Filtering-Correlation-Id: beee7298-9a66-4962-e416-08de8b3fc829
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|19092799006|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	dccmLjrBLkBAZqvFYAA+Ii7Zlq3AiK/8IgsMVcjYsf68cUaaGg02SYADt7KCRLcsDjQ5sVfSRcrV9l1YTuINYjl+N15Hz5k8rLnmAz8kXGc3R8NpC4rUKOw65NZ93Jbki4Pj9B2E75VGANdp9o1Xku8mXsWD3NYkl9UWuR/KPibrgae4B/v+ra2Bx1m2fSS/vyiVs+6n8IfCLl8Tleggk/zyi3N4YU4hEm8e6lfyXnvg91kcD/7CE+ZAtTYyoomCLaw3Wv8cViZYZZ+fWdZn5Eh2YDCBenRWIRp3AcaQhM/q/23sHcw8/mYxBVaOLUONULHMyEIuAtEHWVXbx8GaytE5qyjB4bH8ypOB12XUQH+R9SgoHv4rgkP2SBRo8DVaEAWVNZ5351GFSqlFowlvo2VA2SZ5SQgdoSHsP/6yhpiczROuHPpiwbaSMTECLhXBir9tW5Hjc6morZ1yM3zZw+URUChxxQaiktNFcRH55TTQbwh8MbYXOJrO+weDM5DabGq/mEX/wTo+b5RQgmQzSa1QTpma57NnnZ+drJoQteTwQOYwyEHdpfdrBkm+aq35kU09bwOLR5bs6pOYMT+smfYidDs3j8t4sDf3ztQC8C04eUXGPtOznJe4J3hYQhk/L95kKAulSTY86zHZT04SuI9LcoVavDnZ7zDYO1WountCvCpBivR/TvosOTrElyBuNaHjAy+KfQMSqpk3KitUGaEJNYwZ62tGmHIwD7aeDN4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(19092799006)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bE5lTVF3WXkrbzJUdk9yby96UmVpTStaUWJlNUVaMGtDdFVxd1RCSzA0UnFT?=
 =?utf-8?B?NHUxVmM1bFVUWFRpbGZtMWVxTGNhMFRnMUhPeXFYZnF0SWc1VU12YWhOeXVY?=
 =?utf-8?B?L3I5TWNmNi8vZzYwbWJ6NkpLNmlmNEphQmlvUDRPR1laV1pPcU1IOGNIK0M4?=
 =?utf-8?B?WWpKWVlsZitCMlRFRDVBOCtYNWVKWm5vTW0xK2lEckZwVzFxYTVNN25Scm9o?=
 =?utf-8?B?WFdmQjdmTUY2N24yM2xSdjRGRm4xT0hydERpdGRpaWZqc1FucFI0UEFjVnlx?=
 =?utf-8?B?K2hnWVBiVC8xalJmQzlHMkhTbk85VWZXTjJ2NHBwUTk2cGJjT2ZBRHN3aTZh?=
 =?utf-8?B?R0NaRTcyTG1ITklVS3VSYlJVQ1Z4RjZlTVk1bEJqdmc0endOQWVWWFdWcWwx?=
 =?utf-8?B?bTF5OTg0ZEZ2b0Yya3Z3LzRrUlluVFp3Y0VBRkNvNmpTZUhWOTlTOWFpS3JB?=
 =?utf-8?B?YjJkRzFzYnRQUkxXbUkyZ3lnNDNuYUlVUHg1dmdGNGZNRWNlQy9CcCtPbzVV?=
 =?utf-8?B?Umx2SGtJT05FVjFNd1NsN3FMSDBxL0t6VmFFS2ZsRmFMMDFoeWpzNU8vL3Bj?=
 =?utf-8?B?UG9SOHlrUXU2TXNmQWlzaXEvaU5PQ25tNkxUVXhUVy94VGp3Zy9hdDVWbzJ4?=
 =?utf-8?B?VEZEU3E4QjRGbDI3SDdFa3lzN3dPSTNVUGkwT0ZPZUZGRUxHbjVORmloOHJr?=
 =?utf-8?B?VzJlWGw0ei8rd1BTd0Z2dlZ4cU5FaEVuc1cyYWFEY3dtK3VrOVBMS3VrZ2ti?=
 =?utf-8?B?cktlZjRkVjBpVUkwMmZReW5kUXZLYk1nWncrZTUvWGdyaFNuU2d3alNYbXhw?=
 =?utf-8?B?TzVYT24rZmxUVlNaQk4rYldLZ2JjSFBScWY2TWp2a2FKdUNXU0FYN0QxajFQ?=
 =?utf-8?B?SVMxc2xxRDA3eEhkeFVoRU9Qck9HQVZha0c4Vmp4S1dYbk9Oc25JdGlxQ0x6?=
 =?utf-8?B?eXdJUUl5RzRvMXVXSVA5U2pvN21rOWV6ZTdEMk5IblZld3lIUDZVSUJEK1Ft?=
 =?utf-8?B?NHU2N3RJNGh3WGVIOUN1K1M2b2pBcWgrSmJBb0VkcWRRcW9DYlJrSkQ2eGg4?=
 =?utf-8?B?VkRqUmdzOTlWRnFTSjNBM0xFNjFwTkVqVGFraUdpVGhOcTdra0swQ2JMd1Ez?=
 =?utf-8?B?NG9SdGtWQ0NqYUNidXNaZ09UUWJrNms2MmFFM0grNDF1SkxHdnFTTFRJUFdy?=
 =?utf-8?B?TGJVeDRHdHlTZVBuUTlBb2N2T0xCQ0RJZWs2d3NkcEhEOGhjUFhwRzF0bFVO?=
 =?utf-8?B?cWhqNnlqZnZmZ1FFZTVYaXdML0RzWHU0SjFoeXhJcmZydmNrMHhaQzljNU5C?=
 =?utf-8?B?M05JY1FTUzlhbExPbGFDc1pNRDJsbHlhRXdRRXBlTDhVbUFuVkltVE4vZWp6?=
 =?utf-8?B?V2ZnUmhMeXRIUzV1Y2czRmhOSG1UaWtkM3RaK2xJQUdnOUR4OUZJelFFWVBZ?=
 =?utf-8?B?V2Exd1dxTEhCZEoxMkVXNFkvK2UxZEpNd1RsQnFHaTRHZHllUmZzUmRZRFJS?=
 =?utf-8?B?cXR2VHduZUtjOTRWUzFRQjUzUDVYWlNuUi90NGNEUVh1clFCc0FKUDBoc3pU?=
 =?utf-8?B?OEdjYmVZY0JSeDEyMXNNY0FOYTJ0Z3hlcFFwNkhkdkhCMEFQelZzSmpxT2tG?=
 =?utf-8?B?Znl4MTAvMDluVCtxREErM1M0WXF0M1p6dVVvWE91SldxYmY4TFhjeDF4ZWFI?=
 =?utf-8?B?OFpiMUx1akZOR2J6blhYeGhsSzFOZVgwTWF4clJiTGE5WWNJcjdROFFnYStC?=
 =?utf-8?B?MDJnaUNoTDRuaGpaTGhPcU5JQXh5MVJJVTk3WjM0MW5FZ0g4ZThyeGMzQm5s?=
 =?utf-8?B?eXZLWVNZTVFaSFU2U05Ha3hvcFY2b3Z1UjR6VG1KbWU3cDBaODFyM2lMajNw?=
 =?utf-8?B?bGdwdjAwZ2swZUpOSVV6VUdUOXBPQkRnYlloTjYwd3pXOHg4MWJGOEVPKzI1?=
 =?utf-8?B?MWpkYzBaRWlxRnVnUWFyZXY4eDJGNnlndW9hM1BDRGNzbWVNd0hSbU9OdlhJ?=
 =?utf-8?B?NG5SREJ5Z2R6czByVXN1aFk0cHNndjU4LytlQ1F0NndhaVQrZDgydHc1bEhh?=
 =?utf-8?B?OGNzQllIKzBtaTRyN0RDUWlsUmI4dHNmbklhOUxJanhhMEw5WnU0NjgzS0pE?=
 =?utf-8?B?MWZGc3gwZTZZRnA3QldTaVZ2dnlMUWFzUk1USTk0cEg3K3dyTldsMUtkQTBH?=
 =?utf-8?B?bHJUZjdraTdKZmlSK3VUMjBucGhCNUtLRU1jaFd2YXY3NFdvQ3d3ajBGV0JY?=
 =?utf-8?B?bGI0Q1kxTGkwZXBVUTlEMk1yYU5iaFM2dWxsRW1LSVROYTRxWHoxMUpzOVF5?=
 =?utf-8?B?ZVZaYUdCalY2aktMNy9DUnMwSUFwTVIvUytoby9KY3B1c1hQR3Nla2JXTDlW?=
 =?utf-8?Q?ykQ7YzZLk1QY8ToU=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beee7298-9a66-4962-e416-08de8b3fc829
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 13:58:39.2376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X5sJRMRf0a3A9xSm/WAS7Y7mgNR76KYH6QpSDHXGszP2NmYlil49fgQHB7ilC5KN25VmIquMBvXGALgmIPo5AGDZxo2OAS2iTEQhznCeUxU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11261
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7260-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[55b70000:query timed out];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_PROHIBIT(0.00)[3.72.198.72:email];
	TAGGED_RCPT(0.00)[linux-can,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email,oss.nxp.com:mid,NXP1.onmicrosoft.com:dkim,55b60000:email]
X-Rspamd-Queue-Id: 208BA33678D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

The S32N79 integrates multiple FlexCAN instances connected through the RCU
irqsteer interrupt controller.

Co-developed-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Signed-off-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 arch/arm64/boot/dts/freescale/s32n79.dtsi | 50 +++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/s32n79.dtsi b/arch/arm64/boot/dts/freescale/s32n79.dtsi
index 94ab58783fdc..c1a4fdead91d 100644
--- a/arch/arm64/boot/dts/freescale/s32n79.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32n79.dtsi
@@ -352,6 +352,56 @@ pmu: pmu {
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	rcu-bus {
+		compatible = "simple-bus";
+		ranges = <0x54000000 0x0 0x54000000 0x4000000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		irqsteer_rcu: interrupt-controller@55101000 {
+			compatible = "nxp,s32n79-irqsteer";
+			reg = <0x55101000 0x1000>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 0xf9>;
+			clock-names = "ipg";
+			fsl,channel = <0>;
+			fsl,num-irqs = <512>;
+			status = "disabled";
+		};
+
+		can0: can@55b60000 {
+			compatible = "nxp,s32n79-flexcan";
+			reg = <0x55b60000 0x4000>;
+			interrupt-parent = <&irqsteer_rcu>;
+			interrupts = <0>, <64>;
+			interrupt-names = "mb-0", "berr";
+			clocks = <&clks 0xf9>, <&clks 0xfc>;
+			clock-names = "ipg", "per";
+			status = "disabled";
+		};
+
+		can1: can@55b70000 {
+			compatible = "nxp,s32n79-flexcan";
+			reg = <0x55b70000 0x4000>;
+			interrupt-parent = <&irqsteer_rcu>;
+			interrupts = <1>, <65>;
+			interrupt-names = "mb-0", "berr";
+			clocks = <&clks 0xf9>, <&clks 0xfc>;
+			clock-names = "ipg", "per";
+			status = "disabled";
+		};
+	};
+
 	timer: timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
-- 
2.43.0


