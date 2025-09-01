Return-Path: <linux-can+bounces-4402-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C7BB3D71E
	for <lists+linux-can@lfdr.de>; Mon,  1 Sep 2025 05:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77CC3189878F
	for <lists+linux-can@lfdr.de>; Mon,  1 Sep 2025 03:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB8921B9C5;
	Mon,  1 Sep 2025 03:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QVzQSUmO"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010023.outbound.protection.outlook.com [52.101.84.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5882121B9C1;
	Mon,  1 Sep 2025 03:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756696727; cv=fail; b=fMMJD5w8iUSPwpg5LACmON+jddCIMLwXiW9SNdwjrePWgwHsOQGzozt7Gr68x2vpLfIhs4H+xXFsGGEjt7zgMq3qF2iEW8wGA3py9REVmPLlCT1vxVrRFHhDdkc56tndqYIERis+yg6dWkZL1HRncZgEcTOEFsAODFBgrarYaX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756696727; c=relaxed/simple;
	bh=D8jTMKwv+Q+Tzfyf7x7MV4rpWHpkvCnJC4TMQu90ANg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=oQsi43TFvMQKywRDK0Otq7w3niaEKuBknrVoA/c9+nh57aXD8G9HEcEGkCHEX0dlgAnyTQsezxOawfrl1fdlUV7Dg/vaFj8EEi59mpmfR0L+zSdJGZCLjmhXYvQ+OTG30R0SYw3MM4Zaac919htP+hiBcYpgQ8Hnvt8LPoV9TOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QVzQSUmO; arc=fail smtp.client-ip=52.101.84.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Guyu4/9yHHkWH7VoTJ2SV3Yq6agyxtBbRkuUevhVZX5tjnhQZcDl04/hyaU4mgN1Z1YUxtCU8DHlNkgRWo6+COcvXwKqdXPmBLG8+c4Wnqkpm6TwhwUPmVOFTV+BxtRX4Bp6nCaeSytpdK5QTY1tJcYvQ3IGlNvu8SgJDDyfsPvbbBUlAICmtVvMfjDDH9e+1EPt3tYDpYhHn1TX7CFB35vNk8WDmrbxVMLEiqh0HXEysipxG2WNubRKhPWoHeWL2Pf8QKm+wt1mIoP7dx4uSLXyl679YZwQWZFrVHwAtvzrpdDlPYCxfWCgK5dm+1l588HH9EeoxTSN4WykSYK2KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nktFzMF7che1T16BU4RLMejK+XWlwzRhTgf00MuuItc=;
 b=umeiYOocQ3VSf5jX1v/sZCKq7A5Q0Aa2gMdLDrUkJhoZX5ggA2Fcmy9S8shUGWKWdIiAtW5Uk/T7uIItb8vMzS3n8nQesh9zOXVrpkM1GBbqKWj2zLMX+TRWT1JfQCD+9zs/3mlVWKPz6fdNyRpMdCQUu8WUKiStP6IKPMf8+6OEqH0ielgi0v1ZBY6BgniGfEDd+T7QAbsa00nqd05i8u/S4SHOcSIv11mW8RK6IDy8se9ChqsymR5IvV3EGi0MbYvtqIz4UQJ3NkTZcKmB1RNAy4Zv00OP6DgydOT74U0YN2IX06onnrgcgAscC6jbPKnQdJUPL/r+SAh3njP6nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nktFzMF7che1T16BU4RLMejK+XWlwzRhTgf00MuuItc=;
 b=QVzQSUmO0f30OzQSTU0ssp9IorNHmK7ntUYtvfwSQ/myHQKRzx6MRFpIhQ0RmfRrViF49qUDI7Qkfcut3HC5OkAoQIuIKY9X2sXZWLG9/FgdCwUPIvn+M6vqzUk4OPsVIKSyCMzRyMoLLBhV/oYkvJcXV6osJonoyFn2r9uXBybcr5mgFPsWQE7DC88BgboThvPwOVaqR1jkPPaHrrCe85/GMJIPjGSC5c6wuKItCzMQUJfNFec70av4GuXkpHz2ibkLBeYdAWaBQ21jqe0Nvy+X7FdyxsgWKmOxK1ZZcDn/dbhZ0E27FvzSZzk2KTr6mtn78BYdkOgHNr3v7Cbv4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10321.eurprd04.prod.outlook.com (2603:10a6:102:44f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Mon, 1 Sep
 2025 03:18:42 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.015; Mon, 1 Sep 2025
 03:18:41 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Mon, 01 Sep 2025 11:18:11 +0800
Subject: [PATCH v4 1/6] dt-bindings: phy: ti,tcan104x-can: Document NXP
 TJA105X/1048
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-can-v4-1-e42b5fe2cf9e@nxp.com>
References: <20250901-can-v4-0-e42b5fe2cf9e@nxp.com>
In-Reply-To: <20250901-can-v4-0-e42b5fe2cf9e@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756696708; l=2011;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=D8jTMKwv+Q+Tzfyf7x7MV4rpWHpkvCnJC4TMQu90ANg=;
 b=aQNOsG1yR8KNVjne8ru2G2wIboO51iAfzuBRmVMvvbeLvyKsQ8dJKnOurEs9sI+37LAFDQW7I
 tLvzJiTME7ODYw+lhu6Chya3bmIUfBuVcWA1NpuA8bvFkXo+YDOhKrn
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
X-MS-Office365-Filtering-Correlation-Id: d4ea300b-80a2-4bfd-138d-08dde906407f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WU5EOHNOcjlieFN2Qk9ma1ViNFdPNmdRcTljeURNTzdoZjJUa3FiYlBFZ2s1?=
 =?utf-8?B?K1o5QVlVZDgxcWpWcjd4S3hjRXJHLzFEeXppY1ZHZFlhWHhVTmE3cDhNdlFl?=
 =?utf-8?B?RytDQTJQazRNUTRDcy9tTkNKWFZzSjE5Rys4T21MWHFTSHIwQVVTcEkyK1Jo?=
 =?utf-8?B?ZnRiY2x3VlpQNGpUbTJZTzN6eXRrcUNwekwyY1ZhbmIvWEc1SkpJYkUwUWhT?=
 =?utf-8?B?dmxQNG53Z0NXQms4V3dhU09waGNaaDJrVGpkMzRsNFpDUUdTelc5MHNSTEF0?=
 =?utf-8?B?M1pHOEwyUW85ZjJ2VmZVMmtDUnlDUnAyYUJOMUJQUkoyMWxFalRxUlZlOFV0?=
 =?utf-8?B?MGU1YlN3N3FKZzRiU3ZRQUljMzR2b0pjMFNvbkZ3WkQ5ajhTWkl5WjVUeXZW?=
 =?utf-8?B?ZnI4bWhKaXJuYTAzVnJFeE5yNS9FbVB5Z2c4N0ZqNEZqSUdSMGo3SGZBUE5o?=
 =?utf-8?B?WkRpM20rK1BneXRzVnBzdFVKVHJ0cnc1WDhpMjkrWkhVQ2lSc2F3eW85NTJM?=
 =?utf-8?B?SVFielJnRmpxOCt2czFCbHJYUDRIOURmM2pDS1k3YklhNDJ4VlFNa204b1RX?=
 =?utf-8?B?Rm8xOHp4MlFmUHpyQnUzRkVxQ3dEckY3cGkzWWxhRE5RVmROaU14RStMSktL?=
 =?utf-8?B?dXNSRTM5UUgzQlA3TkJMS2ZqVFN0cTlxZXBXUmoxeEpENGRPMlorTTdRd1BB?=
 =?utf-8?B?dDBUWHYyL21mU0YvWXlJeTE4dFozamUrQm1ydTA0R2V2dGRzVExMbTBSeHVV?=
 =?utf-8?B?bXltQnd6bjBvaHlWUDRWYmtpUkdqL0U1c2JobDFSSXVxOWYrTU8rblIzcEdz?=
 =?utf-8?B?aE9PZTdLZ1I5RlpjdE80c3RmV1J6cnZTL1BpZzVCR1ErNTFqTHhNSlBuYUhN?=
 =?utf-8?B?R3BpV0VHNFBNb21jdEthdnk4WXB4WEFKb3VxeExKT2g0ZUdJOUZjUjFHbnJ0?=
 =?utf-8?B?ZW9vdHE4Wk1QcWpvTHZmWlpaei9QMzE2eUNNTmZEeGdvQUYwdEpHL1orMXFP?=
 =?utf-8?B?dFlRRVprbkp0Tk01RGNLclpQTzE4T2NNWU9zS3h6M1J0UEI2N0d6a3NsYTJk?=
 =?utf-8?B?ek11dCtZZ0xjQmpnRm0wZ2t6N016b05Yc2Z6bUZ4WlJZemVJOEFxbmhjOWxR?=
 =?utf-8?B?cTlRZHNtUStoYUVRci95VTFGeGExYmlnVWZEMDAySkxuclRrellISzdnTHdW?=
 =?utf-8?B?TlFsNExjSEo2bUxEOVZUZDNHaExGVTdDdHhVbjZsVzJsNG9ITitmVC95NU5U?=
 =?utf-8?B?OHdOQVl6N3lMeUh4M0swVWxNV2duTTU4K1Eva2pWS2x1dHNnZ1FoN1V5T3lr?=
 =?utf-8?B?TnZBQml4RmVyWUM1RVc3MXg2SGRmYVd4bTRpeUM5ejBOdFJMOGxNYnEzTDI1?=
 =?utf-8?B?VWtGWFI4WWRiOVNhWmlBWHE2ajRydmpmcTFmUjh5cVd4eW5yK2hhemZPR1VC?=
 =?utf-8?B?WjRkck1iN3dFcTM4a1dBWS9vT2I2VWUyUGc4S1VnZ1ZqQ3N0MHhQTlVvMnNp?=
 =?utf-8?B?TGo0WlhJN1ZBNHI1K2pyTTBQMmlrOVYyb2RPekQ4QnBqdjZkck41OHhyOVBL?=
 =?utf-8?B?bmZyN2IwMy9SUnd2Z2Z6Qk55MDEvNnVDTWxrRGVVa1VueTdGYnNCZExpOFhK?=
 =?utf-8?B?QStXZjY1SnRvNTVYNzE4dTZzTmFhaDFqZFhpUEhMSEVMTGdZL1pRMm5wQ2Qz?=
 =?utf-8?B?U2JRL2diQ0tpbDlJZ05LQ2hzcVRrSFZLRk5lTEh0ZjJDQ1R3am16OXlvaEw5?=
 =?utf-8?B?azBETVIyd0ozT0FlOElXcU03dTVaVnNDbXNFVFFuUklEbHZ5Tk1RQlNjRG5t?=
 =?utf-8?B?bUMyNHYwaWdZOUU2WHFUSU1xM3g3UFBDV3lkRHpvMGRXNjhEamkzR2J5cGRx?=
 =?utf-8?B?MUFhZ0gwcGNOUVE3Si9WVDc3Uk9DaWtsY1FTNGZ3SGRtK1laeU5ITER1SGxN?=
 =?utf-8?B?M0c2WE50enFXb3RPSjdGVzVTd0wzKzR4QU51UHdOSDJ1d0ZHaENhTnZNbHM4?=
 =?utf-8?Q?m02tWBeeITgXMfc3FJfS0fqUponyio=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWhDd0UwdWFqUzBITFJibWhGcjNDUzJ6OFVINC9zNEZUWDRQVEJPRHNjalY1?=
 =?utf-8?B?YkZGOUQ4Q2xNQzV2SWxQUHhuMVY0ajhuSW10VGJPeExYMGRVTVhocWNwd3lh?=
 =?utf-8?B?VDB3RCtFOHRleFI4MXFVWGxqejJ5cGR2ZlNlTHRCelF1V2dJN1llQk53SWJu?=
 =?utf-8?B?Uk9yQlQvLzg3WkVRWmltT2phM3hGYTBTN1BicVhML0xEQWhKQ0oyUGZ4ZUx1?=
 =?utf-8?B?Qlh6YlU1UGVnT2o1Vkw0SDE4TW02SHprcEg3SmRKK2FDNEdhS1A4Z3hTMEll?=
 =?utf-8?B?TDQ3LzFEUFN6bjJIWURKNEJrNkg0eEhDdUdIZ05lc1ZZR0s3MHhKa0J4QnQ3?=
 =?utf-8?B?MzhqNE5HMXV6b0VoS3N3K2REYjlJc1l0WFRtWjVWWU5hOWNxaFJpMFRYdXM3?=
 =?utf-8?B?aS9UWjd4clNlWFdmS3o0czBYeFlDdzFOcHlqUlBrakZ6VnhZR2U5Zkp2eTcx?=
 =?utf-8?B?ZU4vUlY2MU4rZVhMKzVod0RRanlNWlhHMXozQ3g5cW80d3RVS1RpYXcydFR3?=
 =?utf-8?B?eHRYYWo4eGUvNzlvelFueTNHdGZrc1htTlRaZytIL1h0Y04vaytFa0F3eDlo?=
 =?utf-8?B?QW9CTjczcmhudVhkVitkODdKT0J4U0x6eVBQLzFTY1VFdUJqYitMaHRDWjJ2?=
 =?utf-8?B?bjFLWGJHK2xIVWFhbXU0L1ZiZGVmaGNkeWtFK2NPOTJnWGp3eFp0cjFQY0R2?=
 =?utf-8?B?RDdIZWsrNHFLdHJNT2Nna0xZa3laclNsYi9RWEZOZGxYakt5dXV4Q1dUV2lC?=
 =?utf-8?B?c1lHWk5halFWaHBLZ3NBRTJ6RG1pQXcwME9zVzlvKzRoRXRER09qa3NFcHp0?=
 =?utf-8?B?V0NIK3F3TkFERjgwOTM1bFV6MlQwZTlwMkdjTG1TSDlSTUpKT010QXZjK2Mw?=
 =?utf-8?B?V1NBNnBBdDJCYVJCeFpzNmk5cVB0NG5VUzV1OFp0RHRxOXZmVEtrRFdHZ2JR?=
 =?utf-8?B?MWlMcnY3amVzd3h6YUpQZitUaWhvTzY0YXpCY3lDUVoydkl5ZTQ4WTJHNGI3?=
 =?utf-8?B?cnBMQk9IU2FNcEV2OUczckpKckVXMEJHc0w5c2hXSkdlcUlGQWZSenpYY3g0?=
 =?utf-8?B?dm1Vbm5mbzBUdE92SXlkUnAxNUtONEZsc3lRN3d0WWRMYlpVWjZYWWxPeWx4?=
 =?utf-8?B?ME5LemRDaDFvMitXY3NWWHUrMnNPUnBPL2pnNERRclR2cCsxTjN3czU3WUhs?=
 =?utf-8?B?UkU1ajFIdVdEbENZb1Jra0VNSm4yT1pYK21kVXE0VWVmYXNBb0JFWU0zQkYv?=
 =?utf-8?B?K1YyRmROU0hTaGJpbFlZSDFrelVCRUdFenZ0cEhQTUhSWC9ZQjZ2UDZhWCta?=
 =?utf-8?B?Sk55T1VJNmJza2JBYjlDZ2FvWDEyYTc5TEk5Nno3M2M5aXBOaS9hUGtXdmJX?=
 =?utf-8?B?SWtLK01tMVl5cWRWZnp5OU14UFB4S3UzbXN5dFlaVzlDaWszRk55ckM1Znk5?=
 =?utf-8?B?L2V5cTdxd0FJRGN3UXVPSjdSUW1EYkR1SXFJK1drVU5ONnNCQzd4ZTVFZzlP?=
 =?utf-8?B?WmQrNEU2amJ6NkFNSHJlUDE1WERBV0xpT1gvOEhpSFhPZy8vZG1yR3lCT0Rs?=
 =?utf-8?B?QVFWZnl2ZkJiT3piUUpITDY5MTZSMDRLVGpwT3h0VGc0c2k4MGQ3MkFha2Nj?=
 =?utf-8?B?YTZ5YnNmUkU3cTQzeS9UV1IwWEhkZW41eVA0MWJBd0crOUpiZ09FMS9qNU5K?=
 =?utf-8?B?TUpXa3g2NXgwTXl0dlgrbkJheFA1YkVrTDhtUWdvdERWMC9zVjhtWksrbnNu?=
 =?utf-8?B?NG9vR3c2Ym1UR2pZeXArWFdrZldQdDNJdnk3RzJVczlxRnNLWFUwcXhUMUxZ?=
 =?utf-8?B?eHRucFV2QWM0M2hHUXVjVXNnUjEzLzVyM1NhbEtXalRrTnljcWVDV2RDVnpT?=
 =?utf-8?B?UnkxOUh5Tk1uWEtQc2w2bERzVzhBNUFjUWpQOVdLanI4eDdwOU05VVpMVlp2?=
 =?utf-8?B?Ym1YaTVkSmMzR1AzZWRuaHhJanNrcTNzVGNPdTN2UkdMUXhMeG5Benk3UFJv?=
 =?utf-8?B?dzcxZWg0ZkpRTytvMEZveHRZY0ZQNlkwNUVzT3F5dXh3bHJiSVlodjlVeGtK?=
 =?utf-8?B?cGFrNWd1ZWY3UDBZQ1pKdVBpWFNaRjRtR28rakVFVVZYZXV0VUloSVJCeExr?=
 =?utf-8?Q?k2IM/ITC/ypm8HMG0uJhgY5l1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ea300b-80a2-4bfd-138d-08dde906407f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 03:18:41.8977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I4zIKgJNI3UpkP4I8rGk01VxYA9zEJiKCWIJoRHxM9/WOvOJB2budSXmJ6OBVoewCNTLqtsgmVISvvdKNf9Qgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10321

The TJA105[1,7] is a high-speed CAN transceiver which is a pin-compatible
alternative for TI TCAN1043 with sleep mode supported, and has a compatible
programming model, therefore use ti,tcan1043 as fallback compatible.

The TJA1048 is a dual high-speed CAN transceiver with sleep mode supported.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/phy/ti,tcan104x-can.yaml   | 30 ++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
index 4a8c3829d85d3c4a4963750d03567c1c345beb91..f8e0c24856a2ba83b5c988b246464f47e11a032f 100644
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
@@ -53,6 +60,25 @@ required:
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
+    else:
+      properties:
+        '#phy-cells':
+          const: 0
+        standby-gpios:
+          maxItems: 1
+
 additionalProperties: false
 
 examples:

-- 
2.37.1


