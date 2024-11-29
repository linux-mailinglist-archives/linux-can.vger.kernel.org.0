Return-Path: <linux-can+bounces-2283-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 867969DE875
	for <lists+linux-can@lfdr.de>; Fri, 29 Nov 2024 15:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46EDC280EC2
	for <lists+linux-can@lfdr.de>; Fri, 29 Nov 2024 14:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AE42E40E;
	Fri, 29 Nov 2024 14:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VamjHE9R"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2084.outbound.protection.outlook.com [40.107.104.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE896F305;
	Fri, 29 Nov 2024 14:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732890359; cv=fail; b=ca+BTyGJPNKZpP4qw1/7LofIPNoqBuc09NBOaCUSF9zEw0ADcXJeXGJSBCHNPkQFS2Rye3Mx33r0/slQJRJRFO29xPEXPsgr+DtU/EgBJ5fdSx23kuLUdClbWo6cJWyV8gTL+hRc7RJ9bBy9IyVt16O0bUCe+zV+/YrYNGQAELE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732890359; c=relaxed/simple;
	bh=z7sgzUHJzovVRjZcaYrA+17RJo1kqu7VsOOZWWx1Ykc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uh4iCkWCe7xoghZSXokzKgYEy55O+fX0kTjmGehiLRI3ZtmWBAnlpQEuJe8zEj9C2lR5prlKtG8pZexapMjwydqEqNTUDNmvpFFHusNo6cCe+MkGaAyYiKUBNodhND3Z4OT3d1yMbxphG7D5g5ugDkVmyBY6i9IOZNOcf0OJ1yY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=VamjHE9R; arc=fail smtp.client-ip=40.107.104.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hnuE0LtkWgB6udSqm8BtLTEo7KBxoc4i/eoftL2kNMdvrYB7l9yKSG8FMv8H/pgbRiDoHRiMEyJtsJ14ETZpw6PuLLgF3PokZx62aL+jRU7h9iDxXv3PyCNs65oE0A/kl34m8hPDqhT0mhQ5YD7Njuuo2EFVwGGiBvz19HW0piTazHDvkKP4s4A8DzUch9HTsSLWN5ZDmekooetkvCJzjNIFmtWXLgfFs6Kb3nI8LPjc27lnPyANd3034zIznaOgv+sRQ3XKEYGLxupmXt+Gq9Qvt/cq/07JyZ/LYl295sx9+DE+Mc3t8u4i6JRAzaBa1LDOhjzBixUvLiB5rQ/XFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifRbbYsxVD/S/XeUi1nthARbnHnUTln9zsV7Ng5LIrM=;
 b=dMuPKxFkY0VUHU8LRzXAvTdhMG5F2ROAMQQJGIcQlMIYf8EzJxJeS9iaoe62QOGJZ/CUMYUoKTMsz++CC3mkgyNfKnRN5wkcY8dNw1efUCnl7sxx8ZsPGQtfiaDV9krYklKPJcnAGpye6aDSbwtzCeeo3FxPAwuB0//oXs2T/1Ugn9/yVQ22onBIq7EuY3aXXcX6ym/gJnoXD2jdHAyRMNPh5EAxiWlscFBQeHiQcwhQa9Uy3bOK7OTYDZXMxaBfnosXypSnOwONqoeNpT/fBampgN067gEA5otdsoMhkaX9CciKskDsacjCqARtahVqNm07xRv80+0ECoilnEb1/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifRbbYsxVD/S/XeUi1nthARbnHnUTln9zsV7Ng5LIrM=;
 b=VamjHE9RWZT7H+nRAyOv5iJ8JiCnXTlhI92vipoENJGUaqQgonBT/rF7SXbttNZvnMkvHZCw9NyeeBn6uNjI3i2I+68oPeLs7nDf8nrmd5zwAvOpCsMRlRWkVNhvP+kx4YV3OHS2xHx253ol59zEjCqDnIKNhOW4ixM4+gaWeS1+jGe5rcutaQj4SFQz6XoYQQ5oaDBeze+qtrOSuKSnD7T05d5HGQ+X8LOFGG4VzqN743by3OWsuHDsfieRD5S+z7Ao9tlMLMcam3YGRwRdDkiRAnOLozTLK+aoOkzAcpG2f9ePsIfAudCCZxpKKVT3Q6XNTp2sZoyJy5Xt8aunEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AM7PR04MB6869.eurprd04.prod.outlook.com (2603:10a6:20b:dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Fri, 29 Nov
 2024 14:25:53 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 14:25:53 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	NXP S32 Linux <s32@nxp.com>,
	imx@lists.linux.dev,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH v3 3/3] can: flexcan: add NXP S32G2/S32G3 SoC support
Date: Fri, 29 Nov 2024 16:25:35 +0200
Message-ID: <20241129142535.1171249-4-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241129142535.1171249-1-ciprianmarian.costea@oss.nxp.com>
References: <20241129142535.1171249-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P189CA0023.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::11) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AM7PR04MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: ff70218e-b6d8-4c2b-0a4b-08dd1081bb4a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TmlCdkw2ZHRKYzRqaDhJTlpZTk9vbmFzaGVSRTBtTVkzb0FqMFNaZEZ0MGJJ?=
 =?utf-8?B?cnZvZ0trZmhCNlBLMXBramg4T2thMExqV3lkWE51Y0RKT01hSHQ2M2M5dURD?=
 =?utf-8?B?VjJ3eVZtQ3JtZ2pIUm5aYmN2UUVjNExtYzRVM1FNaEJPR1FJUEt2UjYrOHRh?=
 =?utf-8?B?STdkMFBmOHdIc3ZrekEwdVk3VSs1M1NiYzJId3NJSDNxN0Z4RWxOVkFXVFNh?=
 =?utf-8?B?YTB1VVNtSWtldGNNckZSVnZNaTlHUXBUUTlJYVpIOTdaTlVERjEybCs4Sk9C?=
 =?utf-8?B?TTJtZys5K1hyUWxScHNZRjFVR2IzVElYWWl0emhWclFYKzRaNk5aT1FEbTZ5?=
 =?utf-8?B?M0NkcFRIODBmcHYybE50OFJwR1JCQlFZMGVIM21aWk9CY0VkenIrQkV4emY3?=
 =?utf-8?B?SUx5YlExQURjaWdweDhOSTJhT0RPS2JyVUlYS1RtNHA4NnRoN0QzRnM2NWJC?=
 =?utf-8?B?azN0UEtrS2tQTUkrdWswdUFFSEQ2WVNDdHRmdUpUQjhNNXJucmc0Q2RZQ01x?=
 =?utf-8?B?YUQ0QmxuMjdHUDJRK29aOC9WdkNmdGZPcjR6ZThxbHl0ZERDenRTQ0UyR1lY?=
 =?utf-8?B?RzFmNTRvT1JCT1RmZjk1R0E3d0FpU2gxdDRldlJqM25wRTErY0VhQnUwY3gy?=
 =?utf-8?B?aTBkemY0RWRKY014VTlKSVNOQ0N3UjJ2cTBNZ2hIM3lVbzFtd3dXZVhQQ3JW?=
 =?utf-8?B?cUNRc1FsdnE1VlVoK0RjbkMwUnYrTFlnTjZza1RlMkUvUUVpNkNIWVdCcVBl?=
 =?utf-8?B?alRiV1JPazJYRkpHU1RxY21TS1FscEpybnRYVHY5T2hPUkxrSHUzMEt6dEZv?=
 =?utf-8?B?WllqS3d1RGwyV2F5bEh3QUlTWVR6UzB6TU1sSFl1aHlTaG9CbGFZanhvWTJK?=
 =?utf-8?B?RXdtRmxpK1BYYjNNSE5OWHA2Q0FWL0o2dDZqRCs4c3h2aXRzdGlRT0s0VFBm?=
 =?utf-8?B?S1BzTFBWVnZmbnduOEhzUFNTWjNtbmZUUXVqQk9ZMHlyVWZoMG9lK3RlNVFF?=
 =?utf-8?B?TFU0MnNtR0VVcVFwTU40QnprU2xaTllFZVBkbytuYmNxZ3NrUk1IMHZvakFl?=
 =?utf-8?B?STBWRmhqamxJUXBES2JKQlhlVExqWlJXNWJuUEtKRHJNR0luQVpYUEsyeU9V?=
 =?utf-8?B?Y0Q5a3prQmkyWU5ESmExNUFPWGdLOU1VVlhiSVVmYmlQT3B0RVRhNEUzaEJZ?=
 =?utf-8?B?OUlKRWlIa0NNcVBHWkJKd1llYSt3bG5xY3RoMmpuaEt6ZEh1L3JCQ3pUdmtJ?=
 =?utf-8?B?UUhlakQ0WlB5MjBiMkZTbjdRb1lsaEI0TDYrdjlVODJYZ2RUZ0pETzRHWHB2?=
 =?utf-8?B?SkpDeENwdUJud0hEV1BIbFEvY3NxUmtydm00MDdQWExXczBGcjhQY1NoTnI4?=
 =?utf-8?B?aGRDUWhUTzRwQ0RZVWV2VHJGN3pvUS8rTHpjOUtRdkdnemJHV3BrTkF4ekwx?=
 =?utf-8?B?UDVjbFFZcWlrNWtjSEd3a3V3cTJVeTRtUS9URWMveEtOS1A2VTNNM0pxdDdL?=
 =?utf-8?B?YStHTCt3NzBWMjN2K3k0MEhqR1dJUHVPTkdnbk1DbENrbzUweEhaUVBlMkZP?=
 =?utf-8?B?cldleDYrUkwwL0c5OW5Rb3Q0RVpCbnNTU2NFdTI0MEFaVzh1ZTJNMC81TDdJ?=
 =?utf-8?B?dVFyQUtTbHl3Q3cvNnlTTGJ1aHJzSkF4WERQS1dmZ2szTStwSlg5V0hNQ0JR?=
 =?utf-8?B?bFF3N3U1aldZY2lFZi9ESDA1YmNmQThuZHhZZ0c2aUdJK2ZiWEljZ1Bzb2hZ?=
 =?utf-8?B?Y3dwVXRaMkl6My85MkdWT1pEUGdVZU5Cdml4Rzc1S0hnTXpyRWZzK0krcUNm?=
 =?utf-8?B?dDJOSHExV0IvWW9Fa0pzUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkRXOGdvVXlEeWVEYmpnby9jS1FBeWozY3EzMkJUL3NsYjBrK0ZxSHRxWmVw?=
 =?utf-8?B?bmpRZzVCVk9tNFBJRHRpK0tVK0lOZnVTNnc5VTJmSHBqYU9PYXRBK1VlbFRF?=
 =?utf-8?B?ZUJHamRlaWNCOVovc3dqVEJOT2JTaXg3WXVIQXVJYUY4cmRzY0RxVmZaaVFL?=
 =?utf-8?B?L0o2NFk1NEJZQS9OelhmaHlpcHI5bWNodGtuZHg3WmpSeXpFZWV4akRNM1B4?=
 =?utf-8?B?OTVDTEVsV0c3N1NZb3h1NVYva1lhWGtmNGhUZmltVkJYWk9pSnpzMnRWcmE0?=
 =?utf-8?B?RUNzcWxEcnlsMkJLeTVZM3krcldtcFBzeHN6aEx0bllHdmh0L1FWazVXc1dl?=
 =?utf-8?B?dCtYTE51cVc3aXFtL3BERFByUE56dGN6WGczQVUvWk0xc0MrMWNmYTVNbWNU?=
 =?utf-8?B?RWdsTUo4ZWhMT2haSXNtdC9sczk3YnNjcnovY2JUN1B5dkRMd0JMT081SXVN?=
 =?utf-8?B?eEkrV3NMT09HUzlsemgzMytYSEhEbkpyUFYrOHBTUkNtSXJvSjh2bnFaTTRP?=
 =?utf-8?B?cDFYUHRoV3gybmVWZmFWRkIxNTIreE8xMFBIbUtGZDloSFZFN2lSM0oxaUdL?=
 =?utf-8?B?UHh1TTZJY0lEb1lvdUZHcGNFbGFhYTNQV001K1Z4SU1OYlMzNXBpdGZwYWRE?=
 =?utf-8?B?Z3FhdUR6VmRtVjBaaUNkbFlyMjFUa0tGYmJsQ3BwQ3lmTFA3RUdzVTJ5NGFG?=
 =?utf-8?B?VUQ3b3ZwTmo2VEtDa2Fvc2RrUFBrL1dqQnpqa1dTS0dUVXc3cSt3UWhJKzl1?=
 =?utf-8?B?RzVvdmEvdHhLTmkrVmo3OFFwZTYxa1N4VXVQMFdzWkJqWTh4SEJpcW1nRmg2?=
 =?utf-8?B?eXMwWDVYS3lXdWsxYXdvNjlpNytGYWxqSk9NbWVwMXhUNTZ4ek9kdWZhTjRk?=
 =?utf-8?B?Y2w5Si84a2FRNE5KcVdiUzlqYnNHOUZMZVMxOWZuNEtwT2NNRnVGNjNNeSt2?=
 =?utf-8?B?enlMcWpNU2ZTVnJRakp5WTFzb2pxV0lmM250UkxRaEdiUmpSSG0yNWFkS2pB?=
 =?utf-8?B?YTZzdVVsM1gzV3k0aHNSM2ZpZ2R1RGp6a3M5OUN0ZGhVN2p5Vm5OcTQ4Y0Nl?=
 =?utf-8?B?THhsa2J4QjFMM2pTNUxTb2pkNDE5aW51SWs4K2VzazFqdk92MjBLTlorZjdZ?=
 =?utf-8?B?K0dWVGF3ZVZLbk1UUDZhZHJQTlh0QmVkRnladlZlenNmS1N4MGUyQi9VcnhM?=
 =?utf-8?B?NTRTS2lITHRkNFpselVNdFdsTW5UejR6NVpOcGhxdnYwVmVEeDVHNE5uSlQ4?=
 =?utf-8?B?bTFEcTJrS0FSTVlpWXNPMUgrZ29vSnJHK1RQWUQrbU1CSkZ5aUNobE5uS1Ay?=
 =?utf-8?B?Rmlia3JaWmlZeis0SlV1TXdCalR3K2ZuTVVZNEZDZGFzODgrTTYwMzlSNEhm?=
 =?utf-8?B?cDBCV2JlM1lqYVZLeEk1K0ZKMXZhRGw1dXdsaXBnL0s2V1ZOS2JmSVVQMC9a?=
 =?utf-8?B?SzNBb0thSWFEL01rWlNQeXNCRHdMU1MzKzhBbkRET0FpVjdSejRVMEw2MVFX?=
 =?utf-8?B?bkRWbFd1U3gzYTFrRUo4Qy81bXZWMllPMDliREFJa0phQ0trb0JJME9vTWdO?=
 =?utf-8?B?UUlpSXVXdUxJODJ3UVJyeVVOamp4dkIwd01MeFQrbHJ6YVJLUDNmUGZCL2t3?=
 =?utf-8?B?U2dZK0RIUUxZT3VmMEs3a0hXL09PcXQ2OXlPendJSStiZUdTSjFISU1NUnJm?=
 =?utf-8?B?MWlDMkNYUHRPNDBTaXMvOWpFS24yNHRFVENXei9jcENwWWlyMVgvZGNmUlFu?=
 =?utf-8?B?MzJRWGJKUkpUUW9PaVRPanpnS05rS2twbmE3bWM2bys3YWN5MkdYZVNlUDhz?=
 =?utf-8?B?bFllSmpITG9oQUp5NDlDdTNpb0xtTGtOZjBRYnlPd2FlQTNHRjE4M04zczZr?=
 =?utf-8?B?UERVMGR6SjhmRW5KVTMrYU1ONDRtU0VXNEt3TW8xMXpnNlc5cjFWSmh4TFRw?=
 =?utf-8?B?MXkzWmNvNFRuTDRJYURDL3UwaGpQeGZKeDc5ZmNML0htS0FVSTB1VjZLcHJH?=
 =?utf-8?B?ejhCRTRrRGFxM3JoRUVWL2hiOHd4MmF6ZTM3c0JFeWVqNzNqRDh1dSsyMWM4?=
 =?utf-8?B?T2owVnAyVkNRN3FvV0szL2tudXJHSlhkb2lwL1dCcXdQNkRtekZuMmNueU4w?=
 =?utf-8?B?dVNNUm4rYjM1Wi9GSlROSlU0Y1pLOHMrVHJmdjNDWE05ZDlkdERoY1hneWVS?=
 =?utf-8?B?L1E9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff70218e-b6d8-4c2b-0a4b-08dd1081bb4a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 14:25:53.7495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P0oKiq7f0JW7ON1yEKqGexpCZv1XZ3o26iI5DWTEtblZvtIq9UjiYX28hiONWCT4+IpkkxBRakbHFVTjOi6b0jO9YeqPGTY7HG36W2yWqmY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6869

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add device type data for S32G2/S32G3 SoC.

FlexCAN module from S32G2/S32G3 is similar with i.MX SoCs, but interrupt
management is different.

On S32G2/S32G3 SoC, there are separate interrupts for state change, bus
errors, Mailboxes 0-7 and Mailboxes 8-127 respectively.
In order to handle this FlexCAN hardware particularity, first reuse the
'FLEXCAN_QUIRK_NR_IRQ_3' quirk provided by mcf5441x's irq handling
support. Secondly, use the newly introduced
'FLEXCAN_QUIRK_SECONDARY_MB_IRQ' quirk which handles the case where two
separate mailbox ranges are controlled by independent hardware interrupt
lines.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index 3ae54305bf33..282297c55502 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -386,6 +386,16 @@ static const struct flexcan_devtype_data fsl_lx2160a_r1_devtype_data = {
 		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR,
 };
 
+static const struct flexcan_devtype_data nxp_s32g2_devtype_data = {
+	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
+		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_BROKEN_PERR_STATE |
+		FLEXCAN_QUIRK_USE_RX_MAILBOX | FLEXCAN_QUIRK_SUPPORT_FD |
+		FLEXCAN_QUIRK_SUPPORT_ECC | FLEXCAN_QUIRK_NR_IRQ_3 |
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR |
+		FLEXCAN_QUIRK_SECONDARY_MB_IRQ,
+};
+
 static const struct can_bittiming_const flexcan_bittiming_const = {
 	.name = DRV_NAME,
 	.tseg1_min = 4,
@@ -2055,6 +2065,7 @@ static const struct of_device_id flexcan_of_match[] = {
 	{ .compatible = "fsl,vf610-flexcan", .data = &fsl_vf610_devtype_data, },
 	{ .compatible = "fsl,ls1021ar2-flexcan", .data = &fsl_ls1021a_r2_devtype_data, },
 	{ .compatible = "fsl,lx2160ar1-flexcan", .data = &fsl_lx2160a_r1_devtype_data, },
+	{ .compatible = "nxp,s32g2-flexcan", .data = &nxp_s32g2_devtype_data, },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, flexcan_of_match);
-- 
2.45.2


