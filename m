Return-Path: <linux-can+bounces-5029-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E35F1B9F5D0
	for <lists+linux-can@lfdr.de>; Thu, 25 Sep 2025 14:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 284A81C21187
	for <lists+linux-can@lfdr.de>; Thu, 25 Sep 2025 12:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D5B1DE4EF;
	Thu, 25 Sep 2025 12:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="JG98DOmo"
X-Original-To: linux-can@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023126.outbound.protection.outlook.com [40.107.162.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE9F1F5F6;
	Thu, 25 Sep 2025 12:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758804789; cv=fail; b=E8+iKpepKndazuUIJxM/eOP8MaicN6aFQyf5XdyjjnG/m1gDdeLa65TrS7/1i+zFlcbT92WxTkme9gG97cCPzcRb4W2dSxuHEz8cfu45JyFuWOLB6LTpuT6AHIkQEmzjdBQOBOQRRK5yJzJ1OI3CqDsy5PpUefFhwBiWw87d9O8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758804789; c=relaxed/simple;
	bh=19Yr9cBd1wdIpj4oqHz7OO49ghVv5RWl3W9maL6eeBM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QY/VSr5lRMGL3LIefLGW7dAePUPUMBcXH9RrAUafvAHE3tZnlobmyklIZDNIJZaQ6mPZrd0hDCJWERZYTWdzqrGDOR7zTMngUEksa2yWncUVNwYoVyMLEwxQ4zRciSltVRCwBLfAH15bSiPsD5H/DpX+sDkA1aPb0Aj1al0p3GM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=JG98DOmo; arc=fail smtp.client-ip=40.107.162.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cGo/ILBXgZvsKJVAr//8+i0aDD+bUGKuqJKHeAeFoIDAdQGV5rP50aUytBROr2/ouE0Ww8Yo1AHCt/MHsvhncxZ+LvOKfioyU/ysbdgZrQQ3HA4o10e8vw4pvmB6qKJQGe1DFECIeRgjTqI4c8poQNys/4QC+Bo8DDcyDf1v0K+8VPFdsoYbwOiBwniwZBX6r5g7r0rnkQIxgV2KDqV9iUv7osw0cDZ/XHSDjgwxhjinhSmrWOc8u/CXF7pgHVhTxYNkstxuucvjogya4/diP6vA19GgRGpBntuh0Hr2pg2PFjyiGjRhaTY3oqafaozaZYM9dYmDCcxA6jnCDHuBNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19Yr9cBd1wdIpj4oqHz7OO49ghVv5RWl3W9maL6eeBM=;
 b=vAglyDRR1Su2dioqjJCZg0TxmO/Xp1QVltQ9tt0PuXQqvFzcM31b+OnBnda8azH/JiO2fsOnUInOWh0aDtoaOzukJl99tjyjHOziUbvMBl1w6gsSQoOXaXrrV2hcVVWSHrWMs9ILuIGp8xMO8L3+QWcKtPzLTVk/+1ifgbul3q4Udi+FzUWusB23cKIxA3NNzqPxVUBvB1SFPcEBpy3Kt2hJjPanZI8xRppv/L1I/1F1IKXhu7dsdN6lB3ZDUGR8oYGAsqTut3zGBc8fHpMA9FfLSzpexPtH0GdIBa/iHdXENktDfX+WEZs2vDkyTaBp0UCxRJBqMMFQ041EpcQPPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=esd.eu; dmarc=pass action=none header.from=esd.eu; dkim=pass
 header.d=esd.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19Yr9cBd1wdIpj4oqHz7OO49ghVv5RWl3W9maL6eeBM=;
 b=JG98DOmoEp5/xE5hO4DvfnF72czKnk8JwnJjhq4zVuyDmy9jQ6fsA/9tHt5NBDQjNA7oi1X3B6pC5mjeGMgquv1FiF5q3tAlDMi/vMpK09TIr1++OpuZo4v1OS8Cktc5F4OeWXb7ZroKmY48d5+A+44fOdPBeNORzPZhoJRaf6E=
Received: from GV1PR03MB10517.eurprd03.prod.outlook.com
 (2603:10a6:150:161::17) by AS1PR03MB8150.eurprd03.prod.outlook.com
 (2603:10a6:20b:4c6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 12:53:03 +0000
Received: from GV1PR03MB10517.eurprd03.prod.outlook.com
 ([fe80::cfd2:a2c3:aa8:a57f]) by GV1PR03MB10517.eurprd03.prod.outlook.com
 ([fe80::cfd2:a2c3:aa8:a57f%7]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 12:53:03 +0000
From: =?utf-8?B?U3RlZmFuIE3DpHRqZQ==?= <stefan.maetje@esd.eu>
To: "mkl@pengutronix.de" <mkl@pengutronix.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH net-next 0/48] pull-request: can-next 2025-09-24
Thread-Topic: [PATCH net-next 0/48] pull-request: can-next 2025-09-24
Thread-Index: AQHcLSxJ8kmkdCtPLU+/n4dJpl9LE7Sj0qeAgAAJqAA=
Date: Thu, 25 Sep 2025 12:53:03 +0000
Message-ID: <c433c2ad1ee19299a46b3538327f4fafb7a25165.camel@esd.eu>
References: <20250924082104.595459-1-mkl@pengutronix.de>
	 <20250925-real-mauve-hawk-50b918-mkl@pengutronix.de>
In-Reply-To: <20250925-real-mauve-hawk-50b918-mkl@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=esd.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR03MB10517:EE_|AS1PR03MB8150:EE_
x-ms-office365-filtering-correlation-id: cfff65fe-4e1c-4d4a-c774-08ddfc327716
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|366016|1800799024|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?UWNuU1psTWRxYlVCdVdWSkQ3Nk80NWtQRi9oclhFVWt0YkxPM1pYMkVyL1ZX?=
 =?utf-8?B?VTFOdGZ6MDBQVEZUemlPZDV1VXJHOG1uT0VMODZoV3UweFdoM2RQQ3NnZ0ph?=
 =?utf-8?B?WHpUOEJkdmxVVDBrUVFHdmFyMG84Mm5pbDIwNlpYRGtGM25BRnVOM0JRcUpZ?=
 =?utf-8?B?ZzhEeUZvaWN5MGlIYS9vS0U3eFRmVUJZRDRVcElmYit6ZUJSYUVzUjFsdEZT?=
 =?utf-8?B?UXlHY0Z0aEJrb2REVFdLMDBiU0w2eGxSUkNiZ2R2NzVyYWVQUHEyQ1g5Q1B2?=
 =?utf-8?B?V0M1UTM4Y0xjUmVRa0J6SWMxSytBY0tteHExQTQrb2dyb3FxZmxlWXpGZTRW?=
 =?utf-8?B?ZzR6YzF0bkRNY2lpS3RUR0o1cytRcmlQUWZzd09zeGZ5cGpTVHdpM2IyNTNl?=
 =?utf-8?B?N2hZQ3UrSWZTVUczUWtDQXQrYjhXKzB0T3BNVGIzSUgxSmo0VDRUenVZTzVn?=
 =?utf-8?B?NFlMVEx3cHpNbU9MYTYrRkJzUEM4L3drSyttRFNZSnhKN0JLVVR4YTNIektz?=
 =?utf-8?B?dytDS09XZHZaVmo2WlJkWTRjNHh5SEUwRUZZU0cwekZ6K3Y2bUNzU2FPUFJm?=
 =?utf-8?B?dUQ0NzZ2RTlUc1B5WkFJSXRlU3RVVGFTQ2RiM1c3anp2a2huc0x5OTF0c3FZ?=
 =?utf-8?B?Q2FqeXRXTWtUMWRwUzRZT25zSFkrU1Ntd00xNnlpU0lEbnNCRmcvSjhmUFIy?=
 =?utf-8?B?d0ZSWDhRWGZkNDluNXZ6QUJlUkxmRTAvVnd2bVp6bit2RmcwYS9VcGtja2o1?=
 =?utf-8?B?Mk9zb2R0T2ZYb2tnNUw0MXZsOUpadmdSd2dLMWViYkFPY1VKMjBLSmtndmpz?=
 =?utf-8?B?ZzUzdmt2TzVVODQxWkJxaFZXa3dxTHdYMEc3ZXpzNHd3allybFA3Q2JtZnB4?=
 =?utf-8?B?RTVtY1drRXd1NC82amVhQmg2TEJIYy94TzV4a2V1c2tzLy9jekJOaGlKbkZx?=
 =?utf-8?B?d21BaGtRS3c1ZzBGdXRFbCtzVHpqbVFkN1F0UXU2TVMzbEV1UmhTR2RGZUtH?=
 =?utf-8?B?eFljcHVhN2YyMVllZnRBZytWN0Njc1A3bVQ0RXVZSnNLVkZEZHViNFJLcHVs?=
 =?utf-8?B?TUNNd2RZRXJERCtLbjBOamsvUUJXOVZtK0M2Zmg4ZVlpejNFMkVTMGtvY2pp?=
 =?utf-8?B?KzZqQmY1RkhsNndzQ01YMXVNTlJnbEQvdXJub0U1bVBVSWhHK3NmTkpCWENs?=
 =?utf-8?B?c1pXS0ZoVWNDTVN2ZCtCR3NLODdrcFNnczBudHB1OTVSNGZmbHB4Q3h6UVA2?=
 =?utf-8?B?R2RFdDJmVnUzTiswNExrSGVxckE4MU02T2ZBODNXVmZiQkE4bDliamM1cDVq?=
 =?utf-8?B?TXo0OUNQSnVnb2lzMmdOc1JNSlJKbDF5Sk1CU0ZCdlNsQVNvNGVJV2R3L1g4?=
 =?utf-8?B?bmlIdDFwbktsSTRIckpNYzdwSzB5dVdIR2FhUTd2M0JVdEZxVkdKdVVkSmE2?=
 =?utf-8?B?WlNuU3pHMUdsWnY5MS9DMjJNM3Q1MStWRHJKeHhRRnZHRUNOWWJ6bFVtLzRv?=
 =?utf-8?B?V3RLajkrU05CVzBXWlFyUTlnQWlqRGZjYTVRS3JmVllZM0VMaHhtRUNaeTE1?=
 =?utf-8?B?bUwvK0JRVTNETEgvaWxXZ05URnBWc3BmTHF4aWhpb3RDcWRxSjVZYyt6cXJW?=
 =?utf-8?B?T1VudUo0T1hTVUFVeVMzbGVyT1BHZTRFL1dOeFV1dUlJOXZVeXArdlkxRUw2?=
 =?utf-8?B?V1ZJRFQ2SmdpSXFnbFMwazR3Mys3dTVqbDBjWEY4dHMzci9xc0d5aERjbHZa?=
 =?utf-8?B?RjRvL08zRURGdThLcXpUTm9vMWZ3Y1F3eUgzNko2QXkvOXA5SlJYWW8raDZl?=
 =?utf-8?B?cDd5MGhZSVBvL1lOdUI1TWg5amhHaUJBRmR0L2FHeXhhTDhhdUh0UnFLMWlW?=
 =?utf-8?B?V3RhUGVhd2JlS2hGRDlUUmsxYWRTTU03MGtHdno1aHlpRnJncjdIK3lQeVZJ?=
 =?utf-8?Q?LMRLGXPemX0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR03MB10517.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(38070700021)(7053199007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eGNsdXVhWEdDc1NJdWZzdGIwU1Q0TTRXNlJJcHNCNUJ1cEhtU1d3RXdYSXkx?=
 =?utf-8?B?dEFYdVM0ZFNUdjViZVhsdGZ2NjFRVFM3UnFzdGFER01EM2NZbDFSR0o4OEVs?=
 =?utf-8?B?U1ZDekhOejBjRzJPNDFwblhuNXh0RzRVaDB1cWd5d252UC8yVFR0d2hPQXJ0?=
 =?utf-8?B?T1RmM0Y4VEY1a0QwaU5jMW1HWVV6YUM5bkdpclFxSXM4SnJQV29QNER3SUg5?=
 =?utf-8?B?d3hlYUZXR3ZLekJaNEUvNzVUWmlWVklIODMwQjJSbW5RaEoxZ0tNS25zWmpu?=
 =?utf-8?B?dVcyK3FPQ3ZCc1cvTDcxa0Y3ZVZlT1JESkNyQWJwQnFCcTBrRjAyR1IrUXk4?=
 =?utf-8?B?UDFYZk4wNExXdTMxTVIrNnNxa0gwR1RqNFRvaVZWb1Vta1FFd3E0WklyRnVl?=
 =?utf-8?B?bkZIYUkrdVhSWVh2TVFnbDlhTVB6WkFqVjRCWHI0M3NIaVQwMWtaaThhMkh4?=
 =?utf-8?B?cEhKankzVTFvVTNmRW8zSWdUaVpPMVJVUVJvWHZybEVIczB1UWF3Yjc1dnBt?=
 =?utf-8?B?Znk1T04vbFI3VWFOMTBmWWFkZm5YdUo4ZFdaUG9ETE5MWHZBRFhkeTFRREJE?=
 =?utf-8?B?Szcvb2E4N2RUdHZ4VEV3djQvZDAvVnFoNVJJL0RzdXF0LzRqTjh1RGhxdHl4?=
 =?utf-8?B?U1YwT2RzK3ZsQ043TXJ5NXV6TXJISk1CZWc2a2lrNFgxWlRGTUU3a1pwNXls?=
 =?utf-8?B?V0lOS1FZbXExNXNzcHJjVXZJMk9yWW8xUXAzcGFjR213a0dtcVNYeGVoUXhN?=
 =?utf-8?B?UHdQNlViQ0xZN0ZJb1RsMElObEhwVVNrWjJZQ0k0Znh1MzZGTzhZb3BRRGlh?=
 =?utf-8?B?ekY4RGxWdXk2QWdXZFJGeHFGSDJKWTUvWC9lNFZyOUQwR2VSRGlKUkNESjQw?=
 =?utf-8?B?MUpDUmFrSlVwZHhYdTh1L0NUMnpKTWNIWkwwUEVUT05MNW5DN2Nkb29ybDZQ?=
 =?utf-8?B?S01wZENZeEhZZ1pYZ3QyVjRLRzJ6RnBIUnRXdTNPWGdHejlrQ2VtSGxKS0o3?=
 =?utf-8?B?cGMxUWg2YTVMNW1hZENUT1FYOFNvbVRobXQrSlNFMFlyRHRNR0N1OGttTytF?=
 =?utf-8?B?VEhzYlVpZlEyOUlldCtYVStWdlFabnNETmt0NysyNzVmaERkRDhGdVhGTlBN?=
 =?utf-8?B?U29uNEJHRy9NSDA1UEwrZjdhaVYzOHh5VEtaSE5MSXVYaytYL3UrRnA5T1FV?=
 =?utf-8?B?Q0VXZytPM2JWSE0wclo0T0djdGNPZEpMTkJ6ZDVtRDhmT0trcWo1MXZjNjNE?=
 =?utf-8?B?eWNId0JBdmhZUUlZcXorUm5iNlA3LzVqd3FacWl3bmpBUVV6TXlwd0NodlVi?=
 =?utf-8?B?TURxY25jZVlrdzlrL3R5UlFYSWNLNGJ0aEdrdlBwRkkxSTVWTSttT0Z0ZG1h?=
 =?utf-8?B?V3RvNWpUNjFpaHRERGVZSXVlMkJqeEswM3p6YUc1dkJhalBuT1pId2dtdFVm?=
 =?utf-8?B?S1JiZi9ncFZVMXdjeGcwVmo4Mmc5cDhwUVMwVUVlZW82TGR3bDJkU04rMTM3?=
 =?utf-8?B?U0JGcHBDUElscitkckFtRFJ2b2JmNTR6SnF0cXNqSHdicXZMZmJoRFdvMTFS?=
 =?utf-8?B?K3V2d0NJS21xQmhva0daWVh5eklPRndzeVBmVmpuVTNxVG1ZdEs2ODZRNlFP?=
 =?utf-8?B?T3dlaEhEZnVSNXZqUkFZeHBBME56N2J1QmZnUVY4N2JtZWpSRC9FNVNGdk9r?=
 =?utf-8?B?NDVTbHRBekxjUXV3azdvelZJR1lpd1RsUmJrVklEa282SEFLaW9RYWoydmRz?=
 =?utf-8?B?azZ2RFUvZ3lvVElka3EzYjgzK1lGeGE4Uyt6cDhVZitmRUFLd2xLRkZoalNX?=
 =?utf-8?B?OTBnUlhYaG9RaHplWG1ZV2wwUXpveHM1MFdxUDVwR2JnUUVXSHM0MzlqOGdD?=
 =?utf-8?B?Y29TZEd5VVVlenJOa1IzdTVrb1BpbVM5NElxamhyWitTSys4dXFkSDVCa01K?=
 =?utf-8?B?cnU3YkF2SVFBUGs5RU1PSk0zcks3VjdYdHZHdC9Mc09jR2hUZXg0VHlWSnFu?=
 =?utf-8?B?M3Rmb1p0Wm9pbVZ5NktvbzZxVHNKbFlndDh2bVA4ZHpBTkJMbHVPL204bk9V?=
 =?utf-8?B?U3NGMHd1aUdnWmVoV3JBV0xRelRhL1BlYnNIN2tMTGxPdTNBajREZG1ndDI2?=
 =?utf-8?B?YVlwSGJvd1p3NTdaWXpjWnJFZTl5UUJDeDlncUhBYkdPRDZGTkNDSENuQ1pj?=
 =?utf-8?B?OWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F909768508F044EA74B21DC34FB6D74@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR03MB10517.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfff65fe-4e1c-4d4a-c774-08ddfc327716
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 12:53:03.2418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rF7Dq80BRruJHf+8IrdNDhZi+fI39Uv4/0PP10ruinOOuQLrv7RfRGYl7YiaWZNNRm1Q8Gq6znvsYs3rd3vv1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR03MB8150

QW0gRG9ubmVyc3RhZywgZGVtIDI1LjA5LjIwMjUgdW0gMTQ6MTggKzAyMDAgc2NocmllYiBNYXJj
IEtsZWluZS1CdWRkZToNCj4gT24gMjQuMDkuMjAyNSAxMDowNjoxNywgTWFyYyBLbGVpbmUtQnVk
ZGUgd3JvdGU6DQo+ID4gSGVsbG8gbmV0ZGV2LXRlYW0sDQo+ID4gDQo+ID4gdGhpcyBpcyBhIHB1
bGwgcmVxdWVzdCBvZiA0OCBwYXRjaGVzIGZvciBuZXQtbmV4dC9tYWluLg0KPiANCj4gVGhpcyBQ
UiBpcyBvYnNvbGV0ZSwgc2VlIG5ldyBQUiBpbnN0ZWFkOg0KPiANCj4gPiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9hbGwvMjAyNTA5MjUxMjEzMzIuODQ4MTU3LTEtbWtsQHBlbmd1dHJvbml4LmRl
Lw0KPiANCj4gcmVnYXJkcywNCj4gTWFyYw0KDQpIZWxsbyBNYXJjLA0KDQpJJ3ZlIHNlZW4gdGhh
dCB5b3UgaGF2ZSBhbHJlYWR5IGluY2x1ZGVkIG15IHR3byBwYXRjaGVzIGFzIHBhdGNoIDIwIC8g
MjEgaW4NCnRoaXMgcHVsbCByZXF1ZXN0LiBTaGFsbCBJIHN0aWxsIHNlbmQgdGhlc2UgcGF0Y2hl
cyBhcyBhIHN0YW5kIGFsb25lDQpzZXJpZXMgYWdhaW4gKHNwbGl0IG9mZiBmcm9tIHRoZSBvcmln
aW5hbCA1IHBhdGNoZXMgc2VyaWVzKT8NCg0KQmVzdCByZWdhcmRzLA0KICBTdGVmYW4NCg0KDQo=

