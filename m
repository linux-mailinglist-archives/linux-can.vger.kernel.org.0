Return-Path: <linux-can+bounces-7132-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JlNFFByumkeWwIAu9opvQ
	(envelope-from <linux-can+bounces-7132-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 10:37:20 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9D62B92E5
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 10:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9997A30E4413
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 09:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AC33B3BE1;
	Wed, 18 Mar 2026 09:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dbwTF+1g"
X-Original-To: linux-can@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011034.outbound.protection.outlook.com [40.107.130.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7CC3B19B6;
	Wed, 18 Mar 2026 09:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773825755; cv=fail; b=pz0uYjtKCsl6LfWebGtqLNKOdPasukwDQ9vpCQtAgWEljpthOlAW9N3m3DUIpiqk62c6p2ZoD77aT1FTlSwZPcdHV7VvWnj+0tdI5GIwmcb37xAWXml/NWheP6yIGCDMH3VvzHPSYlEDB00Td8bzo17paB/cCNbToR6TX+uh2Ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773825755; c=relaxed/simple;
	bh=NjkkmEQvIhu/ukpc3rYoo+G4FDElFzZoJ0lqkJdSKiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=csWXKLI4qp8vjolvooQHGky+hfZp5clsXXO+XodPA8uuyv7EsZt0cM3z6rcYROlKET0mQQdlr7YF0o21+5+RTlyXq50aYjoSRRzYkLTeCjawml9oA9E55wVtr+ZfywoCRYEYPdCqj/gluZOOwYIzIxASOViq4Il3frPaEZlFad8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=dbwTF+1g; arc=fail smtp.client-ip=40.107.130.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d4dH3xZMNbmeeUGMfdBTCoUYsyGzBJ59DGIsd/z3Ntrouyxrj0/yZic88gftb9/MCYYjCUfxBb8le2GvRUyB8bQ+7oirsUJd8tIG0MjQoqd/+S/TEAal0Bt9nn4vkKcheV67wnp6mlL0QbSWZK9PbGq3TP1KKLWPbuwXI0aqnJyzRuzAdhSqlakdZYyEC2UDXRs52z6MbRZgLbmWdnKG0QFVUma7yb2vLGZVDesI1IxocwhbNrfHmz+h/tGO9ysMHMs962f2BNvtVOuvXEX7TzlwCfc7mdiyuRTf/5E2JhyJdvx8Ip0a6jzTv8ibxfD1aWElEAXo6XfVlMR/rDHx3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRQouUAtAoFM2r1Ht6OLIZn6BKh+s2A174EICOx9dcE=;
 b=e2KIDeISFDTITY9AjwV0Vnh6+0y3dFNzDypskZqPfHqy69t6cusAwTlHIDK2tg+Ywrx9tt86RiUhXZBQSt6i0pyXpbC4SowVsAyXQRYTMZWQ03PrFO5zs19tG4ERKvyWjsEm7LvvUkfQd1XOy+xIHKbypr3ZccNZJD57cv3lIhbTUPDDA2q+f/eC4QoMCLKjzmJOnHHDShDRPUeaXidKea/RWFfBGZM/Gq2WWuDFCN0QZbPE1alw+2JRh4vRXcaQqUiS8kq6aummd4ipEBqfUEaRtgX+pa7ad4vQb9Zz1VpD1d7T715byRsHg2FsQs3gZOLQa9avDluukjFo8P6lrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRQouUAtAoFM2r1Ht6OLIZn6BKh+s2A174EICOx9dcE=;
 b=dbwTF+1gkMC2KcRmRXEGJk6VBaCR9a2c3yaxNnrGZCmfl5hDVqJ/+lX17uFLgdPQtVRzAR5EoCsBaAxaTlLnpszl575mRDUGKJkzeKUbuxQkfWrX10YEX0+prag3VX49q6l0d+0Bl5qQiXJ+67Qm1gewemPqCLpzgZ1yI/KU6/l9AJ41pEwub4D8oMsrTSA+f/OHSULSQb1LczK4CBL1bnCfEXXoHeWWEbcJ8Xk59kg9i9zwHaD0veAg8uthXun7sDDyYFVuDD3wZ+hAYXrS+pK/6ZX6/7oVwZsyolq/zJzpxuAfVgzaB4I94VSuRnAayRoXG5i2uewFTTe+LgNrVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PAXPR04MB9708.eurprd04.prod.outlook.com (2603:10a6:102:24e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Wed, 18 Mar
 2026 09:22:25 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 09:22:25 +0000
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
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH 5/5] arm64: dts: s32n79: enable FlexCAN devices
Date: Wed, 18 Mar 2026 10:22:15 +0100
Message-ID: <20260318092215.23505-6-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318092215.23505-1-ciprianmarian.costea@oss.nxp.com>
References: <20260318092215.23505-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P191CA0021.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::26) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|PAXPR04MB9708:EE_
X-MS-Office365-Filtering-Correlation-Id: 4773bb2c-90bb-47f9-2c30-08de84cfde0d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|7416014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	odpRbZIP8qnTJHL8jLs+/BAoSyZzGge+1uYQPtLugT1dL10ZF7CUNld/cgizArhSI4ipBdwesmwOjsuO07MWa4XzazX/OsI8GQORH65NPxi2mu9AiAohVTSLrxm7xX7l0WvXYkzW+os/tsLgczLdJ/4zZqJnr/rYVFxBEm3PkgGgM15o/dsUHqPJB/6fzREIBpDrcztuvgv8ccHzxi7/xndywd8FYJbLWeiHl1hJEL1uBYqwPocdBuXqm0n+RC1XNJN5M1u+ae2AKBnU45JizsZwzFSMD18Dl4lji/F2NKtjTj8HoEeP4fJiOveBIWNrWNxYYZZk9vM/fpOkIXvL4d8JYQgZWWoSkCfgAMIGa08/ODQtLsvzPMOVb77nZbisr/mw9VTtQhuTfyxPy9W78C/or+dzXmvYE052ETg5MOPrm0j3XEHfOq5RlpiwPhMtFUjB3g7lrZ8AGxKHqfRTMOcvrUnRSzDPy6Mp8XDGWZ3DlsilG5KaRN8ZBIOFEWpx3gaig3/KYy2bGLoPxXrt38rBX4ubGqw+KsH72qTEwvamQFCAl1juQwXDEdBg3EthoRWipyavU4Nl3z/uASMXWZVKhND4Ek4tAVSBbkO+ThcASFGo7uRf5M9rT5V5gFY26Sczv8yEQYnyGTRyZJJNhZXcelOuTBSrM5xLH3wOaBS5LN0qwd+j5zXYU/pqqIBLGzL4ahqonHUF6nNdfHox5R6xhlpMxvQUekZa9/aA8Wc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(7416014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUdNZ0VjVlZlYnVwbW56TS93MGFCbjFRZEc1OHc4elAwVWFydVh3ZUdZek1v?=
 =?utf-8?B?NTdUUmd3OExWRkhyRHlpSW9zazBSM1VUOHRkS2RWYWdYOU5nOE9XcThMZ0lv?=
 =?utf-8?B?bS9jWGQzclo4c3ozcE5EdXZnOWI5MmxqblgxNWp0TTdlQ2QwRGtoSXFLcTVH?=
 =?utf-8?B?ZmlqN2ptUDYzcTVQZFprdmxwR2dnbDlMZFBrRmdYbTJkV3NPWm5tS21WSEFT?=
 =?utf-8?B?OWFoWUxIMFU3MG5YMjhFVmdTK0lHMzVvbVBUVlp0MkRqSEhmeDNsTHh4Nkcx?=
 =?utf-8?B?UStVOUY1NCtESThoUUlhdVlDaFI2QzZKR0ptemJoVjdkTVF2SjRDWVRMd1RP?=
 =?utf-8?B?dzJ3eWVXUkdxNzU0UTdtZkNKckplTTlmS0xtS3RqU3h6ZzNwbzRkamVXNlhR?=
 =?utf-8?B?ME1ZSHZhZlpUZDg0MVljOWI4dStqQU4yaUVQamw1WXV3RUU1ck0zQzlLQkJt?=
 =?utf-8?B?REJicVhnRkgyc2Z3OWVzTFdoc2s0MnRsK05ZSHN4eUhGL0ZPblBCQVkwRVV2?=
 =?utf-8?B?N2k0d016N0FWdXorbkJDTElFZ0dGVUw4ZkZuMlh2dld3WXRNdE9uTFZtUzU0?=
 =?utf-8?B?d3hiYllKUzRUcDRESGZtV3MvZ0hwUzlMSDZCVTFHYXBqQ3dQbFdhSkxEYUxS?=
 =?utf-8?B?QmFvUjJjRmJ5dFdVc054d2xFR1dwVEQrc0NZQVdvdGVLQTcwM0hkd2tKbVBO?=
 =?utf-8?B?Q1lmelpQaE5RSTcyNGhqY0E1UTRMYkRhdmg2UFRqalFaQUZBWjJ2ZFNIWXlx?=
 =?utf-8?B?SUV4UkRZdHQrN3QxbkhXSTJreHpkTDR1dnQyZkh0SDJEbzNNZUxYZ3hDMVRj?=
 =?utf-8?B?RGFaU1R6TUZDcWprdFlBazNGamlzU3FDVFZDZW9vem9tL0NzeDI2eUNHWlpX?=
 =?utf-8?B?TXB2aHB1emJZZ2dMSHRYVnZTWVRQUEc3Yko4RVBmcjhRT0Q4UVlCWUpsOHhr?=
 =?utf-8?B?ZklmWnFsNHNKYUtqc3Rwd2paZzNGZmRuVHpYVGV3NWtrdnZHNWJEdkcrcG56?=
 =?utf-8?B?R3JDREdWZW81NTc3ZGdLaVEydHVod1V6bHZIMDBNRWt5REpjMzM4N1pKNkJn?=
 =?utf-8?B?RUEyNmlQZ0tuMGM2aVF2RVJrOTREWGtJZFBMdmNsQXZCbUJRSHhMbFNKVDE4?=
 =?utf-8?B?V0VWY0VzTE5yRUROVU14MFVPb0UxamVnaUxBcEU3a0ovUEhsSHVQRnFiSEdP?=
 =?utf-8?B?UEdSS3dWbGxVOGNEWEFkT1h0U2c3aXIxdUhOcFZFeEJwYmlXT29HYmtxSXVj?=
 =?utf-8?B?NVE4aGxYRU9jeXlOajRUTCtPbVNJMkRRWG4rZVRGRlJQSkNwUUx1aU9sdkov?=
 =?utf-8?B?OXRJSGNsUWpGWEhxQVJvMmpmWFFneW5ZZ1g4ejYxNkVKQ3ZYLytkTUNtTW1E?=
 =?utf-8?B?THp5REQ4Qnl2Ky9RV0kzTnRwcUFWaWdRaTg3Vm9SMEJDRk85dHU4N0I4VGxR?=
 =?utf-8?B?alFPSU10QlNQc0g3czd5UDg5WUJJMU5zRktTblhlYmkyaG42aEY5eSt4emIv?=
 =?utf-8?B?N29jTms3eXRhM2pmdk05SXU2ZVROUlhPOHFPbVhNY1lDeHZxOEhYTHVVUXB6?=
 =?utf-8?B?N2RPTkJDSWZoTHRHT1R6ZG80aDdsTzFscmExZWtnN3BHS2l6T2x5QXBDM0F2?=
 =?utf-8?B?WGVybVRIeHZVM2tTNzd0aWxSdnZMZm84cEtxVVFWVjVWKy8rSGZKa2c5NVh3?=
 =?utf-8?B?dXkwVnlMVG5JdlRxVFZIUVppOC90OUpQMWZJVzR6TUI2SDgreGhiMTdMUG5t?=
 =?utf-8?B?RXJsbWtYYStaNFZ4SkUvTHpkaXFUSFdpS0o3T29lZVZXZWpqZVVBYk9NUGYx?=
 =?utf-8?B?aVdOdkdFMUI0TGw5Mld5Y1E0ZlZBQ3o4NEFDUG94RG5kUStLWjJ3TDNvRFU4?=
 =?utf-8?B?L0ZUZTZkblp2S2kzdGFkdG5EK1NnRGIyMWVGZ2FWOENkcmJhMzRJYnFnWUZB?=
 =?utf-8?B?bGlkVW1OOUFjTGdYNDFZMmFudFlpNGYzMXFRRnlxZ2xnakRGY095aFBEOFE4?=
 =?utf-8?B?SGVlMXBKTndRd0dRNHRyenU2djJYWWZTckNmazgxc2lLamRCeUdmSUFtQ0hD?=
 =?utf-8?B?QnNiZTFqMnlWN0NsWVh2Qms4WE16djlwaEJQWE8rSThVcXlDUjM0cEg2Wnh6?=
 =?utf-8?B?OTdsM0JET0YvaHFaTGRwUVhGNGxMWEkxWFhqS080M2lqdi9nZkFXdlRkeTlz?=
 =?utf-8?B?eWs2MU5HVWZjYzFjRm5wMWUrS0FCS1pNcFN0NjJ2ZTdsekxxTHQycGVVZnI1?=
 =?utf-8?B?L2FvTmFBM3FIZEk4NUM4Y1ZKbjJnMEgra01zOXRDQThINmNFSmJBOXJMZ1BB?=
 =?utf-8?B?OEhQTWV5SjNmM2RNUmgvNVhMb3hjSWdSZVN3SFhadVVTSW1wRjgzSjBhcFlp?=
 =?utf-8?Q?Y858kGoyHe6JvvJw=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4773bb2c-90bb-47f9-2c30-08de84cfde0d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 09:22:25.3457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: blDUtY+Iny6icSqaZStfSnVSkVEOosjSz4ZfZbrsrvWXps6+VhTy+LO28nlFv7iIuiFqDTsY93y9poTDVzTxbGmljz6O2mJCZtOAkBoVfn4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9708
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7132-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:mid,nxp.com:email,NXP1.onmicrosoft.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,4.196.180.0:email]
X-Rspamd-Queue-Id: 4F9D62B92E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Enable FlexCAN controller instances (can0 and can1) and the required RCU
irqsteer interrupt controller on S32N79-RDB board.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 arch/arm64/boot/dts/freescale/s32n79-rdb.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/s32n79-rdb.dts b/arch/arm64/boot/dts/freescale/s32n79-rdb.dts
index 1feccd61258e..65a595d7535f 100644
--- a/arch/arm64/boot/dts/freescale/s32n79-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/s32n79-rdb.dts
@@ -43,10 +43,22 @@ memory@80000000 {
 	};
 };
 
+&can0 {
+	status = "okay";
+};
+
+&can1 {
+	status = "okay";
+};
+
 &irqsteer_coss {
 	status = "okay";
 };
 
+&irqsteer_rcu {
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };
-- 
2.43.0


