Return-Path: <linux-can+bounces-976-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F944931C94
	for <lists+linux-can@lfdr.de>; Mon, 15 Jul 2024 23:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D01F3282803
	for <lists+linux-can@lfdr.de>; Mon, 15 Jul 2024 21:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE8313CA97;
	Mon, 15 Jul 2024 21:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="e83qV96W"
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013070.outbound.protection.outlook.com [52.101.67.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A228113C9D9;
	Mon, 15 Jul 2024 21:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721078866; cv=fail; b=eRCDj8f2S2jwUsVtVrvS12GCOYhCILTnyv3ni/x5G2uplzileZFpCVLNXNcEcx/8t9cGW7MJddVZKY7mnOlpQEnELSf8vmoKoh7ZlRB3eAvA4l8cHcsx+WInZgamSAqe9tnvJjV/71d2wj9PLSQdpwYup7KjlzrO1O+brBjbImE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721078866; c=relaxed/simple;
	bh=mT15hObaWTwSv2SHLwwESm2lVFZ3gRWzH0sKOD9wxi0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=paMq2QwfoliqY9t4yahjVawXq4X54GCvvbAo3T4P8L9VWKS+CexBd21erZKKjrVyJZvSlZlYh1FTkFXd4NN6wB1t4EaNF40zAp9EbOyFjMxGEC7HyKz7/sWHGQ55QtpLyr2qn6Xspa3eXP/lrh51YX85vcO5/X+Nhah/92WNBlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=e83qV96W; arc=fail smtp.client-ip=52.101.67.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNSECNrvllm4XnMqyU6RZxBRQfS9mfYWK9iu7n1pdZb5gVkPreCkuE7iA+uU5H2X1qf3rKkX4Hl1ZLb7OekcLw6Fe5MSkS5SdWA8vKLL0DxeBVwY+MmvckX7TgAkkwqB6P+7sC+5roOToXL4CYqyk/SF3n+MyMHPcr0UQS8AGm1I2lTNAGxNscYHVGmnKpKDEG44BYxlHhAJ8Eb0yp3gEoevK16YYxx/Ic74tNcJUD/4JqgviBWymy+ot40ETnKkCW+xCbNOAi4LDOF/OOecU27C34ak0tddTDrOOjh8b5z5d0HzcgLGBbmaQMO9OM7ksCoXyuQMlIpiQ4fvxt/WSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbkVXBQxQVjnfM11TBjBsHzyJzL0huUuh+g/T+f4+Tw=;
 b=pGmPC9uMYKOpEdRaOo4UKsyzhYj4qb9icYIWfBPiCC5+pVwGdpqCW6XGZKSwxzWWEQ/UJ+0agE+6iBlXYvA0OrJPDaUueyJ9sE1Gq+QRKMVpJWMh8FW+424qFVTaBj46Jp5J/eskqHomAuviq/0Ao9c6t6HOsMf/htuhnSG+SHfh/TShiiHdEoRtUnl6gypf5Z/7HCXchIl7MIU8kanXlCJI2Y1GaxO371w4S3IlSbNhljs1vMcfFOSJrg/tQ6Pctq/BWwzSy6ONEzL9+WK6ZIPY+epGqEFU0quc45sQr6yJhf2wpO3R3LNVqdfKh38KUE63tCdqdbeI4OlEB+jrjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbkVXBQxQVjnfM11TBjBsHzyJzL0huUuh+g/T+f4+Tw=;
 b=e83qV96WF2jnB/gQ0TULDaHPC3qTPCzYjQDoD8ncfPAbOaDvs04y87QS/0dllyUE+Ohx+gf1TUza15M4kjm+tJ5/CpWQ6sP1XvPXjOwuO5lM2B6r9KSe4ewl7qtFwuzp30PqrJFtOxANnE2nES4EjBzXFdeR0loGe9g5H1h1Ig0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8275.eurprd04.prod.outlook.com (2603:10a6:20b:3ec::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 15 Jul
 2024 21:27:41 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 21:27:41 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 15 Jul 2024 17:27:21 -0400
Subject: [PATCH v2 2/4] can: flexcan: Add S32V234 support to FlexCAN driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-flexcan-v2-2-2873014c595a@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>, 
 Chircu-Mare Bogdan-Petru <Bogdan.Chircu@freescale.com>, 
 Dan Nica <dan.nica@nxp.com>, 
 Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>, 
 Li Yang <leoyang.li@nxp.com>, Joakim Zhang <qiangqing.zhang@nxp.com>, 
 Leonard Crestez <cdleonard@gmail.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721078846; l=1628;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=80mv/LETBsFOYeyZH+dmpgodqlmtmDmGuf9twFeH9aU=;
 b=83mp7sv/Gi+l5u7zfu9aQWAmS8PRGUIGLNDsYltzmk0tkgkd+Wo+BI2YKUUvcfr8ZlSovBDQm
 dLjAcbDnVeoCwlomPWDkvE1AIUb92O770sXuzD/yU8WP/gKrLfVSP8r
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
X-MS-Office365-Filtering-Correlation-Id: 17fc3654-40ee-4592-3c7a-08dca514f592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RFM1eExoU0d0bVpObFh6TU0xaVluUVNEYXFYbGtpVHlwcHAvNExROHRPZHZR?=
 =?utf-8?B?YjZUT3dqR0FDRTE2NzZxakxmSU00a2RuSEVaMTR5dDFDVmF0QzlxcXB1MHBV?=
 =?utf-8?B?a0g0LzB3QmxVSGJsRHFtN0tkanNaeFJkdzlPckhjT3hLZ2ZlblUwSCt6eEo3?=
 =?utf-8?B?N04wZkV6TUpYYy9uT2pmVzY2bkxMVnpTSmhNSEtLMTd4bUhJUTE0QjlQSzZn?=
 =?utf-8?B?ZEtoNDRWa2ZVaytRMWRtSCtMYU00QjF4UldqQjJVc1RabzBMOTcwZ1dHc2NN?=
 =?utf-8?B?R0JZUXd1S2dhK1RPMjBELzNEMUQ0blc3UDQyYmRESXUraWhwaGdZa1FuSWN5?=
 =?utf-8?B?SndldnZCUEZuV2RxR0dIODQ0VGJTWTdSOS9wdW1OV256NjdEUEV5SDdxYW1R?=
 =?utf-8?B?cTJaeWREdHZUbnZ3ZWc2QnJYbDkrRG1uOFhqZmJ4ZzZOVlBFTDhNQk5ibmVO?=
 =?utf-8?B?NVlGLzJYczFsdjhVZWwvdi83aEljSHBHMWQxWlg5YU9IcU9xY0RYWmRtU2FK?=
 =?utf-8?B?ZU0vMldMakdWTFBBL2djeTNXSSsvcTlvVk5DY2g4d1JkR1VQVlpraVJtY3Jj?=
 =?utf-8?B?U0pUMm1hOVZzZG56WnREKzY2dXJOYVViSUFWM2lTa01qeTNOWGxPdmJ1TDN4?=
 =?utf-8?B?azluQ1NhWktDemx2Y0Y1S1czU3Zpa1JxdFJZN1ZKU2JMNTI2RXRmdHAyMWhO?=
 =?utf-8?B?RHNiZ1ZzYW1YaHB4SDIraUI2WlZ3TlBoOVF0dHJxclhXblFZVkdQYllTVVh1?=
 =?utf-8?B?VGkvZlp0K0NYN1FzRXZ2eDU2QWtNWThxTDJrRlVrSk94NkRsYmFaNGVRckJ2?=
 =?utf-8?B?dzUyS2FYa1FWOU9xMWE1OTFlaVBPSEtBb3ZpcFlhMzR1Kys4WDBScUNNdE1Q?=
 =?utf-8?B?WFNDRFBQUC9nMGF6MGVxVGU1cFFpSkJkN3BHL2JkK2wzTjN5RVFwU2FNcXIr?=
 =?utf-8?B?OUlRWThuaUsycnpWVXBucHhmMmcrSnk1R1pOUk9PenlZK0pWTVU2eSthODRS?=
 =?utf-8?B?UnBuMHFKSk93U0FxdHhhem5Zc2tRMXJSQ3dKaGlVZXRKNCsxSTMrbXlhYkMz?=
 =?utf-8?B?ZURMbkZGTUpab1pnSUNJaGJpdTJNRWxRWFhzbk50Mm1zaGUrS1U4cCsyamc3?=
 =?utf-8?B?OXNoOU5BaUlXTG1nRFAxYWlHNVJ6S0k3Y3JwRzRVeFMwL2x2VXA4WXRRYjlT?=
 =?utf-8?B?aHpoYVZmM2pSUStBMEMwZlN1dW1lRFhGTW96ZTNJTXdVWmd3MkxLRmczaXhE?=
 =?utf-8?B?cXNmUGJCOXJ3UU9ySFlKbSswQkZxMTY2TXVHN20yYjhQanJBUmhCY1pPYk9Y?=
 =?utf-8?B?ci9Uc0JzRlJtN0l6SE5jOUxlSC9xT0VNb1RBVmQxMDdmY2t4TTQ1NFI3bEll?=
 =?utf-8?B?dm0vV01GTFI5N09GdHZmSCs1WlBGNTZFZUU5NEttVmI3RjJRMzJFeUZibitt?=
 =?utf-8?B?aDBOc0F1Tk90VVhWclFNSkptd2xlTENyUnhsNzhMR05CMklmdmQ4cWgyMUtY?=
 =?utf-8?B?Y1NSSnZFRTZzQlJUTWtDMGozanZjSVlkd1FkUWgvN25yR0dsRFJiYUxMZVRX?=
 =?utf-8?B?ekE5WHh3WDRTUzFWSG0wdTY5TFpUeUEwVVNYSHhtRXBkcjBIelgxeE9Gcll5?=
 =?utf-8?B?ZTlRWElkZERJTmJRbVdXekh2TkNYVTdnK3Vub2c1eEYxQm5GOUFoTjRuSjRG?=
 =?utf-8?B?M2IrUVQ3MHF1TDBqTjZneHRmbmFKWXhHRU1jMi9ic1VyTFVLMWpWWWJDL1dN?=
 =?utf-8?B?SjZJRXBHTDdCVXZUN1FXVnR1TXE0UzliZTU3U2loVVEzRkIvZnluamFzTHMv?=
 =?utf-8?B?S3pPZzFZOVdMa2hNVzdkcGtBa2h1cDVjYWdVL3M4MDhob01NcGNVa25Pdk02?=
 =?utf-8?B?ZCtUWUZ5NE4zU2VxbDA2Rm5qV0RkNEVnS2RnZ3lXbzNac3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2hRbnlxZCt6V2Q1OFZNNE54WHlVL0dvMUU0YVluaWJVQjVYcGF3L0tKaFBw?=
 =?utf-8?B?U3pwOTd6NHN5cll6NU0zMU16aE8rS1IwVFdGbWN3QzZtdG4xTytpT05kVWlX?=
 =?utf-8?B?MDBPbzUxaXdpRUdNVFhVazFKNnVkbm5rVXo5eGRtRkVyaDlENFcyZjF4WTlZ?=
 =?utf-8?B?aFpXNU5yeHpMVlZhNDRPbjNSTEFKWk1WeUZScXRQTjZzWloxM2RXV1FReDV3?=
 =?utf-8?B?WFpaT3REcS9pUkNvOHJqQUdtVE1iQUIvK0FGRDFBR1hvUjJWRVpERzNJTEtE?=
 =?utf-8?B?algxdkRGS2FsZmxrNzJwZ0FTRzJtaHRFczUxS3dkZmhVUXFMMm5EdnJVejRq?=
 =?utf-8?B?SHpnVUhrb1RrYWorRzJIMFZOcDd3Wk9oZmpEMUM4ZUN3RHRRWE1sbjFsWkxK?=
 =?utf-8?B?ZE4rb211VGZCYWhzREpYUnVrdlFBUWg1TDNVbVJGME5XY3FTN2UyS0FRS0or?=
 =?utf-8?B?MEx5aUVIeTlYT3VNM0c4VHpSQ2l0OGxieTVZMFhZbXhtU3dsMUdPZXN5b0pS?=
 =?utf-8?B?NlNPOU1vNVp6VzVWZEUzYnUxeVFxZTAzazNVMXNRRFYyYTllMXpIQXZkSENu?=
 =?utf-8?B?NnlFTTdBSlc1RXcxeDdxcE85c0VDSGxrZHhqM1o1NldyazlYTkVlTVA4MUN4?=
 =?utf-8?B?bm5aK1pXTXhWeGErRGw1WW1veTdoYkpOY2xNSDhSdjA1YnB4NlBLNUFzUEpZ?=
 =?utf-8?B?OGx1KzdZTitWa1ozZjVOTkIrMTd3K05yUGRSUmFCcnZuQnlYSmEzMzhQRmNP?=
 =?utf-8?B?SjlwL25jMFp5cEh5bDVEdVVtV09Ed0twRmgvNVRIbVpPSkJEYXRMcnplRHlO?=
 =?utf-8?B?SW9Ld2ZRaTRPbkN1Vy9SOGxKWGtzb1EzbzVqRnJrSzJyYjNXd1FKUFJLRFpm?=
 =?utf-8?B?ZlZXU0s1L0NCNkJOc3dla0RnMDRmWW02UWhtc1F5SVh6cm1kUWpNUC9qR3Fo?=
 =?utf-8?B?TjBVejZQUTU3KzM5NWJmNk93Y3lGL2hyTGtjK3lCZS93TjUza0NWTm5IOC9Y?=
 =?utf-8?B?eTZ5QkVUYTRQeEQ3OURnekRQbW95dG45a01td0cvU3NaVWlxTkgwYzBtcGlR?=
 =?utf-8?B?VGtDa2ZlSU11ZzNwVDZGSFBXYTFsRldXVEV4M1g1OE1JdkFaM3NxdUFUWFFG?=
 =?utf-8?B?ZkFQWmZva3dGUGlETU9HaVRVL0wwZWxpRlVjRHltM0N6V1lpTzQrQzlBcnJB?=
 =?utf-8?B?aTYwM1JNMW1PYkdiN3Rhb0hmQVQzRDBFNVVSYkhvak1ZUjNFeXVTZm5SN3lD?=
 =?utf-8?B?SXJPcXNUYUdpREY3STd4UFEvVzNxNmFiMUJ3YUtUczRuK0g2cFB4SW5sY2Rv?=
 =?utf-8?B?YXoxcmxWTkxzM3NMaFU5Unc1T1lUYjlnTC82bHdoMDhaRnUzclFwcndjVlh0?=
 =?utf-8?B?WkVmMVNwUGFhS0tYZWJ0OWJCdG5yUTZHcjJlN0szUHJzU1NUdWFRZUJpL3BL?=
 =?utf-8?B?SjA0NEx6clVCUENLcUdCazNWRHRvVTMxU0QvRDh2enNZOGNUMENLT05zNWJT?=
 =?utf-8?B?VjRmQWxNOVdsMUVibnZFeGczbDhWVTdDcTBYRU91VWZ6SUlUcndqZnUySU11?=
 =?utf-8?B?aWR0OW9FMmFBV3pWeHE5bTZZUEpmWHVsTzNRVVVqSXRWQ2RRalFlSExvRy83?=
 =?utf-8?B?d3NQbDd3QkhQcGFXbkROVGQ5WEkwSGlRYWgrTE5jTUMvU1Ntemx0VXVpVVRZ?=
 =?utf-8?B?UnBpYURWZEpwWVdTbFc1bXFLbUN3SmUzUGxRVDVMTlNNZlIzdk9XSC81UnlM?=
 =?utf-8?B?MHMvM0hrSG16U1VNbDVTQm1zRm1ZM3p3S21tUDFHOVZiY0U4VjJxSWJ1OWc1?=
 =?utf-8?B?czF5TjF3YTBjTDZLNUx3TENONlZRYm55VW1jWW5teDZwTnFMclBGaDJQY0JG?=
 =?utf-8?B?bWpDejJNRGxGWUlzc2RML3NVdk1Pam5CUWNhbEx6UkhjM3lrK2RxeVFQeUZH?=
 =?utf-8?B?ajJJMjNqZEl3M055aDJ3MWN0b3QxaTlXTFhOcXpWTHloK2xaYTlOczl4NVBt?=
 =?utf-8?B?eTJCL2ZPanpSeUNhMWQ2T3hKRG9ZM05iVDh5dzlyYmZWa05uc2QvSnQ3QTEv?=
 =?utf-8?B?TzFaWEhrTDBHZ3RKYVNnRmFXNFdHUkNIcCtPNmNJem9LWGg2a3haeENKbWdV?=
 =?utf-8?Q?EEjU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17fc3654-40ee-4592-3c7a-08dca514f592
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 21:27:41.8485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hZ2hfrSYsM3UtEOtiwIy5nog1wIWk8393hGQZlX00QHpLVEBiQDeNDIqnMhfjTpDNZOIfiazQa7MuC/1Uo17MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8275

From: Chircu-Mare Bogdan-Petru <Bogdan.Chircu@freescale.com>

Add flexcan support for S32V234.

Signed-off-by: Chircu-Mare Bogdan-Petru <Bogdan.Chircu@freescale.com>
Signed-off-by: Dan Nica <dan.nica@nxp.com>
Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Reviewed-by: Li Yang <leoyang.li@nxp.com>
Reviewed-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index 8ea7f2795551b..f6e609c388d55 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -378,6 +378,10 @@ static const struct flexcan_devtype_data fsl_lx2160a_r1_devtype_data = {
 		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR,
 };
 
+static struct flexcan_devtype_data fsl_s32v234_devtype_data = {
+	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_DISABLE_MECR,
+};
+
 static const struct can_bittiming_const flexcan_bittiming_const = {
 	.name = DRV_NAME,
 	.tseg1_min = 4,
@@ -2018,6 +2022,7 @@ static const struct of_device_id flexcan_of_match[] = {
 	{ .compatible = "fsl,vf610-flexcan", .data = &fsl_vf610_devtype_data, },
 	{ .compatible = "fsl,ls1021ar2-flexcan", .data = &fsl_ls1021a_r2_devtype_data, },
 	{ .compatible = "fsl,lx2160ar1-flexcan", .data = &fsl_lx2160a_r1_devtype_data, },
+	{ .compatible = "fsl,s32v234-flexcan", .data = &fsl_s32v234_devtype_data, },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, flexcan_of_match);

-- 
2.34.1


