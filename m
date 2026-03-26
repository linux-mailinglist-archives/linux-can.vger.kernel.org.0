Return-Path: <linux-can+bounces-7256-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDePD5g9xWn/8AQAu9opvQ
	(envelope-from <linux-can+bounces-7256-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 26 Mar 2026 15:07:20 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD8D33684C
	for <lists+linux-can@lfdr.de>; Thu, 26 Mar 2026 15:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81C7B309B0A8
	for <lists+linux-can@lfdr.de>; Thu, 26 Mar 2026 13:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407BA319848;
	Thu, 26 Mar 2026 13:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GVAJr+ZZ"
X-Original-To: linux-can@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013067.outbound.protection.outlook.com [40.107.162.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4279E315D3E;
	Thu, 26 Mar 2026 13:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774533523; cv=fail; b=YjxQxqDhdne56cfFac7kpYIib5Bh1PnbVmzZiZy5yIyQBtWcNg3G/sp1XCUPrhwTvUzdWT0JqpbwSbinV5F8fBYU6NAIHDvRtjPa6mc+x8elISkNp3RZysEpUjTXH7EDzf2KsPrj1AegsiQGkmVGZI0qXJaeHtjm0FS9SjR9n2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774533523; c=relaxed/simple;
	bh=X73y5eKmEDXMZkOeid41Y9oWjpHvGp3eMNcJyEOVYYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bHeocfbK9NMtoFrwy4l+opHuAFN3GGCWLaDvCBYGRMe1ZxouJ7PRC2qnFJTZyhedBxkRr4u005yB4hdAHOAAlU3m3eWXy5jgiUXB79bCM8kAnK1iJH3nf5xbtVCs+Io4EnhCKnH0Lj8dnqsr6z+NtqRif0rbX7BAms6x6AAWajo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=GVAJr+ZZ; arc=fail smtp.client-ip=40.107.162.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QMxNsIPSdPuzwm/80rchCBFoPYugL2GOln/MjCbAWWg3ZkUYE8IQTtJD+z7xsuY7DITm9MFe3zfhnM7B+pDTEJG22EQhLfcbzFWF8JT4chao1bNBo9O1oopq2CSlt7MRKIA7k30hwrv3YBQrNy1Ai9226MRJE6lzJKq/B0R9f0+rKD/8vVFoC/VWbqn8Ix9iDsgzOU3MuTN0JpQEHLsGQtzTc82LcixiOwz0CKmLfIW5b2aq/O+INqOChxQ7kZS6JRoUzXmQU3yHlij1RIFdTzxz+cFyB9Wmrho8cQLk/GjPX1MLrI8AmqBNb93RWOTx2QZ4sWdTgxwP/JpHHBdQag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZzABiD+Y9NW4W0IfLoq3EPHnlZMdPk1rCC0LnYNhQQ=;
 b=pevO3x9wUTsgBcjiowyEY/n96zdXXOh3ut+Xw7lvu1EAAt7hUdD0uNKdp5b5bI56SB+CoyGEzvHacf6oRNHF+MD3WEn3A62Mfv3N37I4NXdZcB7vwGFiHp3w51kSiq7jJvnNsgV79SUvpz6yYn4oUpCFiuM1UUwpUVWQwKmQEUMshasmQe2kLhCvcTRmdHsZGmPlxho3/g1U6jZCTW13ydLnvVWRD/pDRA8BGkLwLQi29PQt21oPwe14k9tSNwCUjO5ZAGi3vDCt0/eCOrsFWN7EFPqzCefiSn1g0Oxoq9UHWkthDt5YvmLECkGbx9GPqytlOF/D4k3btA5k7K7+Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZzABiD+Y9NW4W0IfLoq3EPHnlZMdPk1rCC0LnYNhQQ=;
 b=GVAJr+ZZMtYos0cfL/qiDyjrtggqBFG/mFwOey/2Kle8CfN3o6DNkPrZZmqa2j6eytD8WYCmLDhLtgJXGVSP3mIiOEuHT64U7hULD+S824phEXm0lPEhPFH5TGa3MGwIzgYiEFydGX8fjy1f2bistZuiU9f29vZX0WuPZx5aOIENq7mpDdej0ohsTC1iP3Dw9CPiwLaYFUbdQ7ENO6YWyKnQvpRW6MVv6y8hodcXRgy0jOtHeO9ieKzWSfbzV8u4Qnevah94qSqvngja/sxuSD3RttdLCSbb22MbNRqGF6khRCaqXJkLA4mhKnW7F6vV+SYOZ10jJGmD4zPwR0i1mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PA1PR04MB11261.eurprd04.prod.outlook.com (2603:10a6:102:4eb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 13:58:33 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9745.022; Thu, 26 Mar 2026
 13:58:33 +0000
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
Subject: [PATCH v4 3/8] can: flexcan: split rx/tx masks per mailbox IRQ line
Date: Thu, 26 Mar 2026 14:58:20 +0100
Message-ID: <20260326135825.3428856-4-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326135825.3428856-1-ciprianmarian.costea@oss.nxp.com>
References: <20260326135825.3428856-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P192CA0045.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:82::22) To DU0PR04MB9251.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 9d9f7d74-bf26-4f15-5747-08de8b3fc48a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|19092799006|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	h6b1dPhzB/qh+3+Cve+b5q+2cctYQIH0AJNFH1KlXTg97cKQrqDq2Is53qvOt4zSK3k9OWqilKIsnoOHJvhqHXvZfOiKsP/982QK1+DXa6YFvxEklKNvajqqJTnKM6FzP2dnBUF43EhH2c9V1hUj28wgmbcbv74qDyQoNMB8/dW4RBMYM5NX8+ts1P5qnxVfBNuYm5I0NUT669FflXhQgJBl73aTM1FB4lnT63yOPnhle/JwDxzDoYRivdkKdSNjUdgUxDHc3L4GmZgnZg4yNqeGg8tmmNdobmj/vt0K1psYKzKBgRyVoT9Gw/Okq2yxsGFCsGaerg6Wbh4rx55Ui4Z0pgLTGRJ9zyVXUce040lx8cSjKQepusbXHHR16ILPHiDy1yWjD1DGNHV3tovww9SvL+LQpb64yow7tSjk0zeoITvac3+JMydg/Pj/1kYUmQmJ58g0GO9TiujH90DoJXRl0qUwJF+WB7oCz3adtfcxOwtINA2CdQYF3F1Kg7ApejziJ6mJohkrJii3SyNtpwZulgzh2pDqd2oWL6iXGrFMGVsCzeQQeWbCiWhD0vMWw9ILwWtKUAEuj/kQq+gY1sP00gnu2zsbYsCWunQquTvRvv1D9Y3V9ON8ThQOAIQ6LqsE6rOMBIks5VIIs9OR5q3SRMWbd1dlUfSNizhP5jq8BVWm5HbZ/sPt0m745UoK7USAugsDdClv3dpPAZHE8BnGFqXAJ0DyhwKRgww0s3U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(19092799006)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3h5VW1NUEw5ekFGY3MzekU1b2hKQkNXeTRXUFRZM0RjUXNCbzRyTGVDbG9I?=
 =?utf-8?B?bE1IMkhoYkVUR1NiRlRWVHI1V0k5TGx6VVY1WVArdU1YQmw2MkZUUlRhWkFh?=
 =?utf-8?B?Z0IzeHVDQ1Y3cTJFVzRkYnA4ZVNDUzBmVjhGVnM4ZHJzTHpicEFwS0NQcmZL?=
 =?utf-8?B?WTNQM01qZFFIU3J2dlFFcjVuNWNwZGZwWU9iUlFDdG9zZ0pjQWpUY1ovRG5Z?=
 =?utf-8?B?NmJzOEJFMWR3UTQ2aFU2QjI2V2JHVXhYcXBCR0ZwL1pXQjNOeG9ib2ttMjdi?=
 =?utf-8?B?VmJRbXBHclJYM3dUUkFWMnJZb2lCaFZNNUtIdkRvZlJuVUF3amwvaUcyVUc1?=
 =?utf-8?B?dllqTm95VUo1R0lac3BoaVFoSTRUU3RobTdGM0pSUWdIeE0ybFgyaUtXdTZO?=
 =?utf-8?B?QUdGb0hablRFaWpwaWVTbGdVL2diaFBSSEQyQVkvcTQvUXZ5bnYvemxXNlZ0?=
 =?utf-8?B?UVRzTmhFdnhEczhhSk1abVlUT2RwZ3NUei9XKzB1eVdFcFFDVVVOOW14R1Fl?=
 =?utf-8?B?RFNvODN2TEhjSXlRaUgybk9aYWdBVE9VY3N1d2JZU1FOVmlFYjNCRTdnampk?=
 =?utf-8?B?VzJ5MUZCQzAvSjZjUnhnSzJva0ttbUZENkpScm5DbkI1TFJjWnBHWng4VktU?=
 =?utf-8?B?bzN2MWJkMk1DZDNUWTRDSHBxL3ZlVkJYS2pOZXROVGJNRkFWUVRiSnZkMHY3?=
 =?utf-8?B?dU4zanFyUEZDSjZ4bDg1TTdPM1ZMV1ZuNDBxN0o3WTJwNnAwa0JQaHhIWVpY?=
 =?utf-8?B?YThCZTA0bGdDcUtvU1Qwc0hPY2FyWHJPZ25OMU14aHlNMkM0WFhXVnhhWW5E?=
 =?utf-8?B?NHl1Ynpla2JPYTMrVWRQS2NtYjkwbFlETmIrdWhDcmc5MFo0NWlhN1NnWHFH?=
 =?utf-8?B?MGNJdVNZdUNER2d5TWh5UVhSSit6RTEzZE9ibUhrOVpvTnVkS2ozN0REWEQ1?=
 =?utf-8?B?d1QwcnFZdis2amQ4dWg4cTRlV0ZyWWpORVYwc1JmbUpqYWtnbDl2bENaSEt4?=
 =?utf-8?B?Y3piQ29iNElFZUJQbDFBbzk1c3FMM1VLcGRScjBBeGFzWU5lNkJiTWRmbVpz?=
 =?utf-8?B?TFFPNFpFZ2hNUmhPaU9jWnZndUNtanNUN3hRQUxRSFRmb0FEZFQ4WlFIWEFj?=
 =?utf-8?B?akhGZUZwRWwvRnJnbUpwZFlrcEdFcndnS1hrUUZ1alVGVzhudFBQbGhicFl1?=
 =?utf-8?B?WG9qMURzcW9lMGhvZWZLaEpWMnJ3YWxPanFyNDlPY2RselFpa3lXTFMxUHFQ?=
 =?utf-8?B?MVpiaiswUTZKckNFd0czbFl3em5NaW43d0J6YW1FK2NtRndSeldDM0VJaHRr?=
 =?utf-8?B?RUM5MlNjZFZhNElpejFCQ2dBczU5UHZBbUEzbCtOZFZGK1BhWi9uUGt2L3ls?=
 =?utf-8?B?bHA4YmNLaEhqTm1pNWlLclVOVWhHRG9DV3c4U3ArSGlLeVIxenVRTWhHeDVU?=
 =?utf-8?B?NERFcXAxYXluRkl6RFFUMmtTVDRXdFFJQkRtdHY5QTJSQWhUWWE4QTRpT1ZI?=
 =?utf-8?B?elcxZWpoZTFvUUdqYm5PT0V6S2ozSTAzTytVbWIxRVZ2OERwYzhNNUJLRDNX?=
 =?utf-8?B?RldOZ2FkNk13S1dQMkZaMk5hc1FiZTlvOTBpazFGRmN1VStPVmxsdVBHbzRx?=
 =?utf-8?B?SS94cmtxYVpvSUhuSE5VY2ZrRjhOZlorOW5uemgxcmVKRzY1YmxOWitndWRx?=
 =?utf-8?B?RGFUVTk5c2dVQzNZcUs4LytXcVhGN0t5WG0wSVJGTVhyTDNHTG1BalZPMmhv?=
 =?utf-8?B?ZnVldmM2ekdFSEp6KzhrSkZ4eUthQURURTBBSkF1K1NtZ3FmTElWWm4vSGla?=
 =?utf-8?B?UnNOVHZicVdpY2tiQWJxRnZiVEE0V1BxVytCRWJzYkY3WkRkVVdYbWRBdDE0?=
 =?utf-8?B?NTEwemlaMWViOW1ZYSsxM3lDZHFmMGxCOEtHQ0FuakdCRHVLNEllNzQ5TVg5?=
 =?utf-8?B?Um1CRm5yVi9CSndpbmhRNEcyOFdsSm5LNkhoVVpTZjc5MitUaFRUN2JEc3Ju?=
 =?utf-8?B?eEd3RkgvcXpvcmJyQW1FMG1pbjh3d2svb3hkenRPQkRUd1NvbWhtYXFHOUk4?=
 =?utf-8?B?QW5pWjBWbUxjQWxIcnR1VFU1WFkzakt6WG5tZ0ZncEtMc3FBNjhJZjJlc3Nh?=
 =?utf-8?B?WGJsR3FxcGgwQm8yTUtoeWtSaC9YRmFZQVpZVjZ3ZkRNeEpSbFlZM0JxclRU?=
 =?utf-8?B?QnpHc0tqWEc2ZVBrSk9NNjJDZGtzdzBlb2VwZVB4WG1yS25sY1lTN1N4Q0l6?=
 =?utf-8?B?R0lWKzlGNTlkZnoxbHNUNkR4Z3NtVll0TXhHME05amVCait5YVhOMXJFeDNG?=
 =?utf-8?B?N3JzY213cGxiY0dNQjRYdktOdnlEVVlDei8yVzY5VWVsaHZhc3lQdFJXN3pn?=
 =?utf-8?Q?jSwRl6bq0v8d4+ew=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d9f7d74-bf26-4f15-5747-08de8b3fc48a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 13:58:33.1270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RdfomhVbhxpNQbNDXtyKKx30ZcGfRh3Cvn+j8i20FW0KzgyvcR2zextloSA+Lro/x1BK/EFf8Guem6Zj1OknG44uQ4RQa5/2XA2zMD6vSMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11261
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-7256-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MAILSPIKE_FAIL(0.00)[172.234.253.10:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,oss.nxp.com:mid,nxp.com:email]
X-Rspamd-Queue-Id: 8FD8D33684C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

On S32G2, which has two mailbox IRQ lines (mb-0 for MBs 0-7, mb-1
for MBs 8-127), both handlers currently process the full rx_mask/tx_mask
range,

Introduce struct flexcan_mb_irq to hold per-IRQ-line rx and tx masks.

In flexcan_irq_mb(), the irq argument selects the correct mask set: the
primary MB IRQ uses mb_irq[0] and the secondary uses mb_irq[1].

For single-IRQ platforms, mb_irq[0] holds the full combined masks with no
functional change.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 61 +++++++++++++++++++-------
 drivers/net/can/flexcan/flexcan.h      | 10 ++++-
 2 files changed, 52 insertions(+), 19 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index 7dde2e623def..32e4d4da00a1 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -957,14 +957,16 @@ static inline void flexcan_write64(struct flexcan_priv *priv, u64 val, void __io
 		priv->write(lower_32_bits(val), addr);
 }
 
-static inline u64 flexcan_read_reg_iflag_rx(struct flexcan_priv *priv)
+static inline u64 flexcan_read_reg_iflag_rx(struct flexcan_priv *priv,
+					    u64 rx_mask)
 {
-	return flexcan_read64_mask(priv, &priv->regs->iflag1, priv->rx_mask);
+	return flexcan_read64_mask(priv, &priv->regs->iflag1, rx_mask);
 }
 
-static inline u64 flexcan_read_reg_iflag_tx(struct flexcan_priv *priv)
+static inline u64 flexcan_read_reg_iflag_tx(struct flexcan_priv *priv,
+					    u64 tx_mask)
 {
-	return flexcan_read64_mask(priv, &priv->regs->iflag1, priv->tx_mask);
+	return flexcan_read64_mask(priv, &priv->regs->iflag1, tx_mask);
 }
 
 static inline struct flexcan_priv *rx_offload_to_priv(struct can_rx_offload *offload)
@@ -1071,7 +1073,8 @@ static struct sk_buff *flexcan_mailbox_read(struct can_rx_offload *offload,
 }
 
 /* Process mailbox (RX + TX) events */
-static irqreturn_t flexcan_do_mb(struct net_device *dev)
+static irqreturn_t flexcan_do_mb(struct net_device *dev,
+				 const struct flexcan_mb_irq *mb_irq)
 {
 	struct net_device_stats *stats = &dev->stats;
 	struct flexcan_priv *priv = netdev_priv(dev);
@@ -1084,7 +1087,8 @@ static irqreturn_t flexcan_do_mb(struct net_device *dev)
 		u64 reg_iflag_rx;
 		int ret;
 
-		while ((reg_iflag_rx = flexcan_read_reg_iflag_rx(priv))) {
+		while ((reg_iflag_rx = flexcan_read_reg_iflag_rx(priv,
+								 mb_irq->rx_mask))) {
 			handled = IRQ_HANDLED;
 			ret = can_rx_offload_irq_offload_timestamp(&priv->offload,
 								   reg_iflag_rx);
@@ -1110,10 +1114,10 @@ static irqreturn_t flexcan_do_mb(struct net_device *dev)
 		}
 	}
 
-	reg_iflag_tx = flexcan_read_reg_iflag_tx(priv);
+	reg_iflag_tx = flexcan_read_reg_iflag_tx(priv, mb_irq->tx_mask);
 
 	/* transmission complete interrupt */
-	if (reg_iflag_tx & priv->tx_mask) {
+	if (reg_iflag_tx & mb_irq->tx_mask) {
 		u32 reg_ctrl = priv->read(&priv->tx_mb->can_ctrl);
 
 		handled = IRQ_HANDLED;
@@ -1125,7 +1129,7 @@ static irqreturn_t flexcan_do_mb(struct net_device *dev)
 		/* after sending a RTR frame MB is in RX mode */
 		priv->write(FLEXCAN_MB_CODE_TX_INACTIVE,
 			    &priv->tx_mb->can_ctrl);
-		flexcan_write64(priv, priv->tx_mask, &regs->iflag1);
+		flexcan_write64(priv, mb_irq->tx_mask, &regs->iflag1);
 		netif_wake_queue(dev);
 	}
 
@@ -1228,7 +1232,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 	struct flexcan_priv *priv = netdev_priv(dev);
 	irqreturn_t handled;
 
-	handled = flexcan_do_mb(dev);
+	handled = flexcan_do_mb(dev, &priv->mb_irq[0]);
 	handled |= flexcan_do_state(dev);
 	handled |= flexcan_do_berr(dev);
 
@@ -1243,9 +1247,15 @@ static irqreturn_t flexcan_irq_mb(int irq, void *dev_id)
 {
 	struct net_device *dev = dev_id;
 	struct flexcan_priv *priv = netdev_priv(dev);
+	const struct flexcan_mb_irq *mb_irq;
 	irqreturn_t handled;
+	int idx;
 
-	handled = flexcan_do_mb(dev);
+	idx = (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ &&
+	       irq == priv->irq_secondary_mb) ? 1 : 0;
+	mb_irq = &priv->mb_irq[idx];
+
+	handled = flexcan_do_mb(dev, mb_irq);
 
 	if (handled)
 		can_rx_offload_irq_finish(&priv->offload);
@@ -1473,6 +1483,7 @@ static void flexcan_ram_init(struct net_device *dev)
 static int flexcan_rx_offload_setup(struct net_device *dev)
 {
 	struct flexcan_priv *priv = netdev_priv(dev);
+	u64 rx_mask, tx_mask;
 	int err;
 
 	if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
@@ -1494,20 +1505,35 @@ static int flexcan_rx_offload_setup(struct net_device *dev)
 			flexcan_get_mb(priv, FLEXCAN_TX_MB_RESERVED_RX_FIFO);
 	priv->tx_mb_idx = priv->mb_count - 1;
 	priv->tx_mb = flexcan_get_mb(priv, priv->tx_mb_idx);
-	priv->tx_mask = FLEXCAN_IFLAG_MB(priv->tx_mb_idx);
-
 	priv->offload.mailbox_read = flexcan_mailbox_read;
 
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_USE_RX_MAILBOX) {
 		priv->offload.mb_first = FLEXCAN_RX_MB_RX_MAILBOX_FIRST;
 		priv->offload.mb_last = priv->mb_count - 2;
 
-		priv->rx_mask = GENMASK_ULL(priv->offload.mb_last,
-					    priv->offload.mb_first);
+		rx_mask = GENMASK_ULL(priv->offload.mb_last,
+				      priv->offload.mb_first);
+		tx_mask = FLEXCAN_IFLAG_MB(priv->tx_mb_idx);
+
+		if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ) {
+			/* S32G2 has two MB IRQ lines with the split at MB 8:
+			 * mb-0 IRQ handles MBs 0-7,
+			 * mb-1 IRQ handles MBs 8-127.
+			 */
+			priv->mb_irq[0].rx_mask = rx_mask & GENMASK_ULL(7, 0);
+			priv->mb_irq[0].tx_mask = tx_mask & GENMASK_ULL(7, 0);
+			priv->mb_irq[1].rx_mask = rx_mask & GENMASK_ULL(63, 8);
+			priv->mb_irq[1].tx_mask = tx_mask & GENMASK_ULL(63, 8);
+		} else {
+			priv->mb_irq[0].rx_mask = rx_mask;
+			priv->mb_irq[0].tx_mask = tx_mask;
+		}
+
 		err = can_rx_offload_add_timestamp(dev, &priv->offload);
 	} else {
-		priv->rx_mask = FLEXCAN_IFLAG_RX_FIFO_OVERFLOW |
+		priv->mb_irq[0].rx_mask = FLEXCAN_IFLAG_RX_FIFO_OVERFLOW |
 			FLEXCAN_IFLAG_RX_FIFO_AVAILABLE;
+		priv->mb_irq[0].tx_mask = FLEXCAN_IFLAG_MB(priv->tx_mb_idx);
 		err = can_rx_offload_add_fifo(dev, &priv->offload,
 					      FLEXCAN_NAPI_WEIGHT);
 	}
@@ -1531,7 +1557,8 @@ static void flexcan_chip_interrupts_enable(const struct net_device *dev)
 		disable_irq(priv->irq_secondary_mb);
 
 	priv->write(priv->reg_ctrl_default, &regs->ctrl);
-	reg_imask = priv->rx_mask | priv->tx_mask;
+	reg_imask = priv->mb_irq[0].rx_mask | priv->mb_irq[0].tx_mask |
+		    priv->mb_irq[1].rx_mask | priv->mb_irq[1].tx_mask;
 	priv->write(upper_32_bits(reg_imask), &regs->imask2);
 	priv->write(lower_32_bits(reg_imask), &regs->imask1);
 	enable_irq(dev->irq);
diff --git a/drivers/net/can/flexcan/flexcan.h b/drivers/net/can/flexcan/flexcan.h
index 16692a2502eb..22aa097ec3c0 100644
--- a/drivers/net/can/flexcan/flexcan.h
+++ b/drivers/net/can/flexcan/flexcan.h
@@ -75,10 +75,17 @@
  */
 #define FLEXCAN_QUIRK_SECONDARY_MB_IRQ	BIT(18)
 
+#define FLEXCAN_NR_MB_IRQS	2
+
 struct flexcan_devtype_data {
 	u32 quirks;		/* quirks needed for different IP cores */
 };
 
+struct flexcan_mb_irq {
+	u64 rx_mask;
+	u64 tx_mask;
+};
+
 struct flexcan_stop_mode {
 	struct regmap *gpr;
 	u8 req_gpr;
@@ -99,8 +106,7 @@ struct flexcan_priv {
 	u8 clk_src;	/* clock source of CAN Protocol Engine */
 	u8 scu_idx;
 
-	u64 rx_mask;
-	u64 tx_mask;
+	struct flexcan_mb_irq mb_irq[FLEXCAN_NR_MB_IRQS];
 	u32 reg_ctrl_default;
 
 	struct clk *clk_ipg;
-- 
2.43.0


