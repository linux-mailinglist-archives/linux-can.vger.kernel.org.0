Return-Path: <linux-can+bounces-7770-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pUqfEwr6J2pG6gIAu9opvQ
	(envelope-from <linux-can+bounces-7770-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 09 Jun 2026 13:33:30 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F2065F885
	for <lists+linux-can@lfdr.de>; Tue, 09 Jun 2026 13:33:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=W43gL4SQ;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7770-lists+linux-can=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-can+bounces-7770-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CEA773000B8A
	for <lists+linux-can@lfdr.de>; Tue,  9 Jun 2026 11:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D053FE64E;
	Tue,  9 Jun 2026 11:20:28 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011068.outbound.protection.outlook.com [52.101.65.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAFC3FCB3E;
	Tue,  9 Jun 2026 11:20:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781004028; cv=fail; b=BQC7OruHN0cV5wmrIAI3RCqLFslIHLgCUu/+gIDgFCeORHj33CodHT+/95AMcseALpRK8yGKmcvJaJG6Q2TWJ72sUZIeAKoU6Uk/VVCfI3ux3zhv3wpZ2ddJez6Ady6bI6+0EZ85WdqCWdqSxEuFkjLDX2FFyLJGDAJYFQFpdgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781004028; c=relaxed/simple;
	bh=oTi9SqL1tIlog0JgvKkhxdpKEBYSyla3YjN0KTp7s2E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NySuwAM60R+1o2vPxMxXaCBuQ/cnung2L1RBiGbQ8E54XRuMyJLWb5ayCATfqnd1Tg0POpyVdc7igNDuNW092Ymy3E+fJx0tcHm4fK9OBCtnbkZvIPrv3oYwOqCjpbSIbduiKN5AvgZJqLVKteciESLjYyoaopf0ojPtAH2gls0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=W43gL4SQ; arc=fail smtp.client-ip=52.101.65.68
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aux4XRZZGfidMiwEeROnm+SLW//oP96VsM2ph7rMw7aqs4iZG/VQh30PT/Sumvi1yEUx5c90T5zWsELwxfaplQr5J/bToYr7ZKn8FWUlrmkZyBogplcwGWcxyiNjRyjADbauU/KcXT9W56twQllRwozMoDTCd7/NB/Cg4MpVen6DihKfIXqJl4F0hfCwb05HgGhuaW6xVBGGzzYv11d/g+KHX9rxQYnVNYSAhDoAS3JOyUOjfcIBmg2QAKPkJbHRCWIp6rhOkUKmbyPV3TSSjBYYURZJReZ0ftfksPEz+nHQVioxxfsSVIvJSepH/3RV+B511ewqm4+SkVdgbICfkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HI875jYf6oZt9E58hwLiPYwC1E985trATMrMqlmvZkg=;
 b=qS3iRSBW5QXFbp85XW89ACiDL+PP3svB/ooGDYiVeWFB9ajTnnTnZ/6CE+QjE+enB2DIh9cEqdXxdvecIa/B9UzYC6IE0rvmYoWIIQuHrL7/laSCEm+9I4vG6s9keYyNtzrdic5v3HKYUYPE7IS7ahBLVk52p2KfoqpSXrJjhL4yUVhiuhIEyoDlWQeGdgQolCvx2CbA73mYNftwqeuqA9TPiNifsjXvIrh3rmScW4sJt2LzpwESb9K0EToHkkolBqPn5k5b4W80IrdFkfvNAVGat1vf4dUzfrrGxJH1sOnCD5rCzobzSbyfH6CZbMYzwqx6MbDYDI+j05595zaG8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HI875jYf6oZt9E58hwLiPYwC1E985trATMrMqlmvZkg=;
 b=W43gL4SQlNm2YqP2hhyotIpLRkPFEjjO+AlVapPrGVOEDoMDyyy2otR6E1eAkxMht9/sUykYkG6+xJf1GADVVYozuHlLpQtIsLTCF8QSOMQvJEXGUdG9G0LnonpubJW9YhLEPCdgAnL4EuKNtqJtv0MjbOL2/ph1bwloQ1aHtvg35Urp5moYb6Fa6BBawoZ3QSuX7MvkfbKB/fKnGHZHzqtH3tDBLV3XIg4TLawCjY7JOLd6DjulmJhAz15FJIEK3n7XcRMFVySOi76h/pJ2RGSi0gHbliE20yZM3Isf3ERWNgzow3puGb6XqmfEp3AWB1amZKuZuPiX/uFDDKsbEA==
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by GVXPR04MB12091.eurprd04.prod.outlook.com (2603:10a6:150:312::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Tue, 9 Jun 2026
 11:20:20 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%4]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 11:20:20 +0000
Message-ID: <a3d15b30-b9bf-4fcf-8b1b-0cb48021ec0d@oss.nxp.com>
Date: Tue, 9 Jun 2026 14:20:17 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v4 3/8] can: flexcan: split rx/tx masks per mailbox
 IRQ line
To: Vincent Mailhol <mailhol@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
 linux-can@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, NXP S32 Linux Team <s32@nxp.com>,
 Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>,
 Enric Balletbo <eballetb@redhat.com>, Eric Chanudet <echanude@redhat.com>
References: <20260603071342.641874-1-ciprianmarian.costea@oss.nxp.com>
 <20260603071342.641874-4-ciprianmarian.costea@oss.nxp.com>
 <c50194dd-3a3c-4193-9296-1e35c6732351@kernel.org>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <c50194dd-3a3c-4193-9296-1e35c6732351@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P250CA0025.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::15) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|GVXPR04MB12091:EE_
X-MS-Office365-Filtering-Correlation-Id: 09219495-2576-473b-9a46-08dec619175e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|376014|11063799006|4143699003|3023799007|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 P3PnJtCJI979lDPZAH8cWOnixaASH9s3va/lK7j2KXIZk6DlUnY+ZBhF6XrmQlIWUVIJ/0a1OtQqNqGCIBSQu+ax8ybrJ4TD6nJEXiE4WtpOReU41YdFdK3JEFB/3RqAvBJTRl4PccFZOHBVI3gqft4PqFa7vdQ5Se5yK+289yxHAx585QlaaaJ/ggHjG/+cmO0zLVDRVjo0WvI+OWbvBXGUA4Y5j49YlNCSRc0148uJlU7dyKKFnwP5HuRqIZno48a6anLSX/ih6gbkZbuDUWEnL1jN8d2AWLNLLFgwcHTQUp4b0612xpAT0j4ZELBXmP+RnvvFiS9bj8DCHz/vz5+/LxjzCEx8Z4MBVIlHSJVwh8iQkouFLdw9ljZLKMCKVDMVHdj4ShVsDdL6Z7HsHMTuGzWzqDwEjm1BPtBhKD9OSVcEjQLOYWIlAhm12t/acTEEZ6xdxkbukBorWmdhiuIo9BwVrPDWyz5QbuwlkOL70TkFIq87Iwl4FEUGaVrL6s6DiCLDobHWlHJv0HXHRhzLQL48YpBIAX1CC5m2aBtDtqrj8IGIMXMYWlEOFz6KvyqOrMyXFN+PMxL/CwZG1Cko7azWRVUP0If6cuBrCLdgnjjP8OI+8A0Qun5GrmKaDmfJxPyKKScBJ0Txebs7XF9QXB88DBqdcYZSqBVMDG71VzZzOhZaCDtP8sWcElhJ
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014)(11063799006)(4143699003)(3023799007)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Si9kUHpHMlcxVTR1UU9FUVNaTDlNb1l6S2FpUHp0QytiQmx4RW4wQUgzcG42?=
 =?utf-8?B?dFZrbU9BNnp6a2JpaStFZSs3SEZqdVZ3RTAxWHFtMWtkODR6ZW9odk9iYll6?=
 =?utf-8?B?S1ZmLzZqdTBRRGpac0NJWEptak5oQ0o1ajZFc2NwWVdYNlU0Q3R4YkNhYnlO?=
 =?utf-8?B?NlU5bDNqUEdWVmVtTUNTSE9oZkZWMUpIRGI3TzFDTFJtZFJHcng5VkJ2OGN6?=
 =?utf-8?B?bG93dFJhVUtOQlM0bVZoMmdXdm4vaE5yWlVWdEdlUGJtUFg0QTBmZzRuTjRL?=
 =?utf-8?B?U1V1MUN6Njd6N2RERzZQd2ZwZ2xJSEhoNzhyTDVBWk02bFl2NXZ2MXBGTG5X?=
 =?utf-8?B?VjJIYzRFZzBncllTYTN2aHh0NlkrYUZRN0tBZlZPZ29oQTFEbG4wT1QwNHIv?=
 =?utf-8?B?NXZJaXhHM3gvRTZmTFMzOU1TQmFQb0MyMmFXbXZoc1Iwck4vY2Z4ZlpsQnU5?=
 =?utf-8?B?OVhaTFNDYlBnNjVGRWtSMGJuMndRUXFpSHFkNHRoNmMyNFBXTCtlSGxMbEln?=
 =?utf-8?B?SkFXK0VwcGNNNjhQa2ZQQ1MyWnF6aGF2d0kyMlVielhJTjVSVnFMNkZTNyth?=
 =?utf-8?B?NGtEMmZmV2xjRVFzV1cydDZKWjN2RHdpQ0t6MVlkVmczUWlqbVJHaFVHOTd2?=
 =?utf-8?B?aTltc3JSdlpEdkFhdExkeTl4YWw2aTl2bWZ6UGtodnNYMG9pSlVpMzNUOWUy?=
 =?utf-8?B?THE3eWVoQmNhSGFsbWRlcGpXekZ5S0IvMnhBTkxUQ3hxNGJ6MEc4OFRvNFhu?=
 =?utf-8?B?S0tacUlWam0vdE5MekpLbEdFRGtRcHBzemh6YURPQ2FlSzh0WnhmUThpem0v?=
 =?utf-8?B?YUlCTG5sQzdHTU5PTmJyWnNMUmh5dHd0dVVSSzFuTFpMb0xZbUZscmlaODlI?=
 =?utf-8?B?RisvU05kTzFHY0dSYWIzWk9ubDZaUTlWcndQUFg4ejkxQWhUeWtvZlVVNTBI?=
 =?utf-8?B?Z1RScWloZmF4cVhDR2lqU1FkbnN5Zjl1ZlQ3NEQrS2dqc2FlQTkzajZFd3Zr?=
 =?utf-8?B?NmRBM1NoMUN6S01pVWpmcFNsUUJFQlpFTUR6VmJYZ2d5VHBXL2F4ZmF1WXhK?=
 =?utf-8?B?dCtlSlduVDhCWk9Ya20wTVhLL2o2bzMyVzc2czZBNk1Sa3gzOVdvblJBTSt3?=
 =?utf-8?B?MWMwU0hnNlpJODJRR2hycEptV0NkeUtjczRZeXJSRDlId2V1MklLV3hvUkZq?=
 =?utf-8?B?bis3UitCK3JFNWo4NCtRaUJFRjJMaXVLNHdRTFBpbHlseXlDZVMxRjhLOEdy?=
 =?utf-8?B?SHhsaFFMbWkvdVQ3b0hxZEpIcW1hZTN1TVFHM1U5MVZRc0lkR283eDJSczl1?=
 =?utf-8?B?SW0wMkVzMEJJQko1RGFOVUtxQ0N0R2didC9GSUNxdnlKYkoyV011SHlpa3Yz?=
 =?utf-8?B?Z25SWXVKS3BHdVJxRnFFM2NPTWJhYnhCRlhBbHB1WXFzQlg4MlBoL3FBRGtt?=
 =?utf-8?B?K3hjYm5TTFFhZmxqNFJRRnh5TmllcVdaKzdzazN6SXZUd0YxRE9tdUhQL2x2?=
 =?utf-8?B?OUpjZk9PdVc4WmRQLzl4N2QybFFaRUpHc3ZaSTIwWVJZVmJNYnFKRno2ODk3?=
 =?utf-8?B?aWxQVjI2dGpNYUtHZzY0UG1OTUthWW9QeWlmYVFwcHNtV1pkSllIRjRKWksr?=
 =?utf-8?B?OFgrKzZGQXZpalVHanVtbzMrUCtxNG5xSzdnQm9mUTV4SkxsSFpadnFtaWxD?=
 =?utf-8?B?cnAxZTVBbHBoNWY5dGptYmFGM250NnVtc05DRjlJUytiVVRCVlduTCtRWEcr?=
 =?utf-8?B?QWdtSlJNL3hacFMyTldQTGk0MjliaGM3Q2MwbHUxTVl0NE5NcWh4dythYkhG?=
 =?utf-8?B?dng1NDJUMnZ6S2hDN00rU3JGRmVTMkUwaVBMeXZqQ0kyYjhuYkVHekJHVnBQ?=
 =?utf-8?B?VERZZ1B6emw2Y01XcUdDbTlPUmFlb2hoejM3TGE4M3ZVUkhMaDRlWkhzNklh?=
 =?utf-8?B?NnZrUGlRR00wWnpwam5WbFh4djNQelhuR1NURGZ3WFVLa2NtaDFYS2JJV1J1?=
 =?utf-8?B?bXBJNE1OZU1WYzJjcU5sU1AvQTRacGFuclZwZ0Y5WGU2N3lwVndLNHFrRENJ?=
 =?utf-8?B?RzAzUmFpMy9HNndRM3JUdVpRVmg0eHFtSkRLcnBrZzNvWDg5MlUwbkxzMTNE?=
 =?utf-8?B?MStGRDdZOEw5RnplYXZyeFVhSFByYTdmS0ordk1BWUhMaXh5UW0zLzkwaUN2?=
 =?utf-8?B?MjkvWlRHd295cjBRWGsrMzVNbXdsMCtiekJQYXBNZXpRcnZ0QUIyYjdzbWpB?=
 =?utf-8?B?Y0VmSFdRTHBZSzlvMHdDaWxTaWF6YW45aVE2dlU1bFFpb29Yby9hOXJiNnpj?=
 =?utf-8?B?OExrRHpHZTZXOWZRTWprb2EwcEJybjl2Q0RBMm5icm1FWngvSnUyMEJoVDdH?=
 =?utf-8?Q?CzMvVDhQRbrt7Dg0=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09219495-2576-473b-9a46-08dec619175e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 11:20:20.3669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NXtVXubRbiHkpHEOq79OUrG1ubgz8I4Pd9tgY1nSsH+DG69Rj0jMeMDm53/crM0/tBIwHzFvg21DHJsxUjxaQaIaqNzVZXbuiK9NIl8JOP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB12091
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7770-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:mailhol@kernel.org,m:mkl@pengutronix.de,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:festevam@gmail.com,m:kernel@pengutronix.de,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:s32@nxp.com,m:clizzi@redhat.com,m:aruizrui@redhat.com,m:eballetb@redhat.com,m:echanude@redhat.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,pengutronix.de,nxp.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-can,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,oss.nxp.com:mid,oss.nxp.com:from_mime,nxp.com:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 46F2065F885

On 6/9/2026 12:24 PM, Vincent Mailhol wrote:
> On 03/06/2026 at 09:13, Ciprian Costea wrote:
>> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>
>> On S32G2, which has two mailbox IRQ lines (mb-0 for MBs 0-7, mb-1
>> for MBs 8-127), both handlers currently process the full rx_mask/tx_mask
>> range,
>>
>> Introduce struct flexcan_mb_irq to hold per-IRQ-line rx and tx masks.
>>
>> In flexcan_irq_mb(), the irq argument selects the correct mask set: the
>> primary MB IRQ uses mb_irq[0] and the secondary uses mb_irq[1].
>>
>> For single-IRQ platforms, mb_irq[0] holds the full combined masks with no
>> functional change.
>>
>> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>> ---
>>   drivers/net/can/flexcan/flexcan-core.c | 61 +++++++++++++++++++-------
>>   drivers/net/can/flexcan/flexcan.h      | 10 ++++-
>>   2 files changed, 52 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
>> index 7dde2e623def..32e4d4da00a1 100644
>> --- a/drivers/net/can/flexcan/flexcan-core.c
>> +++ b/drivers/net/can/flexcan/flexcan-core.c
>> @@ -957,14 +957,16 @@ static inline void flexcan_write64(struct flexcan_priv *priv, u64 val, void __io
>>   		priv->write(lower_32_bits(val), addr);
>>   }
>>   
>> -static inline u64 flexcan_read_reg_iflag_rx(struct flexcan_priv *priv)
>> +static inline u64 flexcan_read_reg_iflag_rx(struct flexcan_priv *priv,
>> +					    u64 rx_mask)
>>   {
>> -	return flexcan_read64_mask(priv, &priv->regs->iflag1, priv->rx_mask);
>> +	return flexcan_read64_mask(priv, &priv->regs->iflag1, rx_mask);
>>   }
>>   
>> -static inline u64 flexcan_read_reg_iflag_tx(struct flexcan_priv *priv)
>> +static inline u64 flexcan_read_reg_iflag_tx(struct flexcan_priv *priv,
>> +					    u64 tx_mask)
>>   {
>> -	return flexcan_read64_mask(priv, &priv->regs->iflag1, priv->tx_mask);
>> +	return flexcan_read64_mask(priv, &priv->regs->iflag1, tx_mask);
>>   }
>>   
>>   static inline struct flexcan_priv *rx_offload_to_priv(struct can_rx_offload *offload)
>> @@ -1071,7 +1073,8 @@ static struct sk_buff *flexcan_mailbox_read(struct can_rx_offload *offload,
>>   }
>>   
>>   /* Process mailbox (RX + TX) events */
>> -static irqreturn_t flexcan_do_mb(struct net_device *dev)
>> +static irqreturn_t flexcan_do_mb(struct net_device *dev,
>> +				 const struct flexcan_mb_irq *mb_irq)
>>   {
>>   	struct net_device_stats *stats = &dev->stats;
>>   	struct flexcan_priv *priv = netdev_priv(dev);
>> @@ -1084,7 +1087,8 @@ static irqreturn_t flexcan_do_mb(struct net_device *dev)
>>   		u64 reg_iflag_rx;
>>   		int ret;
>>   
>> -		while ((reg_iflag_rx = flexcan_read_reg_iflag_rx(priv))) {
>> +		while ((reg_iflag_rx = flexcan_read_reg_iflag_rx(priv,
>> +								 mb_irq->rx_mask))) {
>>   			handled = IRQ_HANDLED;
>>   			ret = can_rx_offload_irq_offload_timestamp(&priv->offload,
>>   								   reg_iflag_rx);
>> @@ -1110,10 +1114,10 @@ static irqreturn_t flexcan_do_mb(struct net_device *dev)
>>   		}
>>   	}
>>   
>> -	reg_iflag_tx = flexcan_read_reg_iflag_tx(priv);
>> +	reg_iflag_tx = flexcan_read_reg_iflag_tx(priv, mb_irq->tx_mask);
>>   
>>   	/* transmission complete interrupt */
>> -	if (reg_iflag_tx & priv->tx_mask) {
>> +	if (reg_iflag_tx & mb_irq->tx_mask) {
>>   		u32 reg_ctrl = priv->read(&priv->tx_mb->can_ctrl);
>>   
>>   		handled = IRQ_HANDLED;
>> @@ -1125,7 +1129,7 @@ static irqreturn_t flexcan_do_mb(struct net_device *dev)
>>   		/* after sending a RTR frame MB is in RX mode */
>>   		priv->write(FLEXCAN_MB_CODE_TX_INACTIVE,
>>   			    &priv->tx_mb->can_ctrl);
>> -		flexcan_write64(priv, priv->tx_mask, &regs->iflag1);
>> +		flexcan_write64(priv, mb_irq->tx_mask, &regs->iflag1);
>>   		netif_wake_queue(dev);
>>   	}
>>   
>> @@ -1228,7 +1232,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
>>   	struct flexcan_priv *priv = netdev_priv(dev);
>>   	irqreturn_t handled;
>>   
>> -	handled = flexcan_do_mb(dev);
>> +	handled = flexcan_do_mb(dev, &priv->mb_irq[0]);
>>   	handled |= flexcan_do_state(dev);
>>   	handled |= flexcan_do_berr(dev);
>>   
>> @@ -1243,9 +1247,15 @@ static irqreturn_t flexcan_irq_mb(int irq, void *dev_id)
>>   {
>>   	struct net_device *dev = dev_id;
>>   	struct flexcan_priv *priv = netdev_priv(dev);
>> +	const struct flexcan_mb_irq *mb_irq;
>>   	irqreturn_t handled;
>> +	int idx;
>>   
>> -	handled = flexcan_do_mb(dev);
>> +	idx = (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ &&
>> +	       irq == priv->irq_secondary_mb) ? 1 : 0;
>> +	mb_irq = &priv->mb_irq[idx];
>> +
>> +	handled = flexcan_do_mb(dev, mb_irq);
>>   
>>   	if (handled)
>>   		can_rx_offload_irq_finish(&priv->offload);
>> @@ -1473,6 +1483,7 @@ static void flexcan_ram_init(struct net_device *dev)
>>   static int flexcan_rx_offload_setup(struct net_device *dev)
>>   {
>>   	struct flexcan_priv *priv = netdev_priv(dev);
>> +	u64 rx_mask, tx_mask;
>>   	int err;
>>   
>>   	if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
>> @@ -1494,20 +1505,35 @@ static int flexcan_rx_offload_setup(struct net_device *dev)
>>   			flexcan_get_mb(priv, FLEXCAN_TX_MB_RESERVED_RX_FIFO);
>>   	priv->tx_mb_idx = priv->mb_count - 1;
>>   	priv->tx_mb = flexcan_get_mb(priv, priv->tx_mb_idx);
>> -	priv->tx_mask = FLEXCAN_IFLAG_MB(priv->tx_mb_idx);
>> -
>>   	priv->offload.mailbox_read = flexcan_mailbox_read;
>>   
>>   	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_USE_RX_MAILBOX) {
>>   		priv->offload.mb_first = FLEXCAN_RX_MB_RX_MAILBOX_FIRST;
>>   		priv->offload.mb_last = priv->mb_count - 2;
>>   
>> -		priv->rx_mask = GENMASK_ULL(priv->offload.mb_last,
>> -					    priv->offload.mb_first);
>> +		rx_mask = GENMASK_ULL(priv->offload.mb_last,
>> +				      priv->offload.mb_first);
>> +		tx_mask = FLEXCAN_IFLAG_MB(priv->tx_mb_idx);
>> +
>> +		if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ) {
>> +			/* S32G2 has two MB IRQ lines with the split at MB 8:
>> +			 * mb-0 IRQ handles MBs 0-7,
>> +			 * mb-1 IRQ handles MBs 8-127.
>                                                    ^^^
> Your comment says 8-127 but the code uses GENMASK_ULL(63, 8). Is this
> intentional?

Hello Vincent,

Thank you for taking time in reviewing this series.

This is not intentional. The driver currently supports up to 64 MBs
(bounded by the iflag1 + iflag2 register layout and the u64 mask).
I will update the comment accordingly in V5.

> 
>> +			 */
>> +			priv->mb_irq[0].rx_mask = rx_mask & GENMASK_ULL(7, 0);
>> +			priv->mb_irq[0].tx_mask = tx_mask & GENMASK_ULL(7, 0);
>> +			priv->mb_irq[1].rx_mask = rx_mask & GENMASK_ULL(63, 8);
>> +			priv->mb_irq[1].tx_mask = tx_mask & GENMASK_ULL(63, 8);
>> +		} else {
>> +			priv->mb_irq[0].rx_mask = rx_mask;
>> +			priv->mb_irq[0].tx_mask = tx_mask;
>> +		}
>> +
> 
> The introduction of the struct flexcan_mb_irq seems a bit overkill.
> Can't you just define two new masks and keep the existing struct
> flexcan_stop_mode untouched:
> 
> 	#define FLEXCAN_SECONDARY_MB_IRQ_MB0_MASK GENMASK_U64(7, 0)
> 	#define FLEXCAN_SECONDARY_MB_IRQ_MB1_MASK GENMASK_U64(63, 8)
> 
> and when you need to access the MB, just select the correct mask. For
> example, flexcan_irq_mb() becomes something like this:
> 
> 	u64 mb_mask;
> 
> 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ
> 	    && irq == priv->irq_secondary_mb)
> 		mb_mask = FLEXCAN_SECONDARY_MB_IRQ_MB0_MASK;
> 	else
> 		mb_mask = FLEXCAN_SECONDARY_MB_IRQ_MB1_MASK;
> 
> 	handled = flexcan_do_mb(dev, mb_mask);
> 

Sounds like a good simplification indeed. I will update it in V5.


Regards,
Ciprian

>>   		err = can_rx_offload_add_timestamp(dev, &priv->offload);
>>   	} else {
>> -		priv->rx_mask = FLEXCAN_IFLAG_RX_FIFO_OVERFLOW |
>> +		priv->mb_irq[0].rx_mask = FLEXCAN_IFLAG_RX_FIFO_OVERFLOW |
>>   			FLEXCAN_IFLAG_RX_FIFO_AVAILABLE;
>> +		priv->mb_irq[0].tx_mask = FLEXCAN_IFLAG_MB(priv->tx_mb_idx);
>>   		err = can_rx_offload_add_fifo(dev, &priv->offload,
>>   					      FLEXCAN_NAPI_WEIGHT);
>>   	}
>> @@ -1531,7 +1557,8 @@ static void flexcan_chip_interrupts_enable(const struct net_device *dev)
>>   		disable_irq(priv->irq_secondary_mb);
>>   
>>   	priv->write(priv->reg_ctrl_default, &regs->ctrl);
>> -	reg_imask = priv->rx_mask | priv->tx_mask;
>> +	reg_imask = priv->mb_irq[0].rx_mask | priv->mb_irq[0].tx_mask |
>> +		    priv->mb_irq[1].rx_mask | priv->mb_irq[1].tx_mask;
>>   	priv->write(upper_32_bits(reg_imask), &regs->imask2);
>>   	priv->write(lower_32_bits(reg_imask), &regs->imask1);
>>   	enable_irq(dev->irq);
>> diff --git a/drivers/net/can/flexcan/flexcan.h b/drivers/net/can/flexcan/flexcan.h
>> index 16692a2502eb..22aa097ec3c0 100644
>> --- a/drivers/net/can/flexcan/flexcan.h
>> +++ b/drivers/net/can/flexcan/flexcan.h
>> @@ -75,10 +75,17 @@
>>    */
>>   #define FLEXCAN_QUIRK_SECONDARY_MB_IRQ	BIT(18)
>>   
>> +#define FLEXCAN_NR_MB_IRQS	2
>> +
>>   struct flexcan_devtype_data {
>>   	u32 quirks;		/* quirks needed for different IP cores */
>>   };
>>   
>> +struct flexcan_mb_irq {
>> +	u64 rx_mask;
>> +	u64 tx_mask;
>> +};
>> +
>>   struct flexcan_stop_mode {
>>   	struct regmap *gpr;
>>   	u8 req_gpr;
>> @@ -99,8 +106,7 @@ struct flexcan_priv {
>>   	u8 clk_src;	/* clock source of CAN Protocol Engine */
>>   	u8 scu_idx;
>>   
>> -	u64 rx_mask;
>> -	u64 tx_mask;
>> +	struct flexcan_mb_irq mb_irq[FLEXCAN_NR_MB_IRQS];
>>   	u32 reg_ctrl_default;
>>   
>>   	struct clk *clk_ipg;
> 
> 
> Yours sincerely,
> Vincent Mailhol
> 


