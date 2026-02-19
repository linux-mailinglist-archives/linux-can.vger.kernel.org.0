Return-Path: <linux-can+bounces-6604-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGGdKSVzl2kSywIAu9opvQ
	(envelope-from <linux-can+bounces-6604-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Feb 2026 21:31:33 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4811F162552
	for <lists+linux-can@lfdr.de>; Thu, 19 Feb 2026 21:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 98160300CA3D
	for <lists+linux-can@lfdr.de>; Thu, 19 Feb 2026 20:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8946324B1B;
	Thu, 19 Feb 2026 20:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nRssySiG"
X-Original-To: linux-can@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012054.outbound.protection.outlook.com [52.101.48.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD81C2820A9;
	Thu, 19 Feb 2026 20:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771533091; cv=fail; b=SRQloZrYJ/bWbf7BJV76ALJNjreFC4CmYWBgSf2OkSRe/swI1l/bNAtVp4YYg1S2UGRfEmpIp7kvBY3/hdcVVlguUAXUhhlz1f9bSiqf4PQRhP67joiFl0863qu1cW5zlx+rSWWOsKEvSuY6o3gFmrig3I9Fu2bMC//Z5d+owJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771533091; c=relaxed/simple;
	bh=0VZpfttNJUiL3Ey1f25v1FAikv7aL9fgksUL6TDcEcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=biGowFzQKlDv3zOiCI5MSi5TtPCahGMgq83Hg+WcdUtYobpolysdC28Gbby2nZPy3fJpHBcHbmRh1fSDqze/Wv0wclODHsZcVok6HO/A7gmc7OahD4CLUAAOhYlvP0fDn3tOBfozslm5ExnzDHNwBTO4QYj43uw8L/hT8lubejU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nRssySiG; arc=fail smtp.client-ip=52.101.48.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gr/3YQWJ+HV/vgRRFseQMfW6A8lD+UKLImWIrioDXoxzwIfSJHt3kdekIyM6/q+byFs6yzlKGVl49iwRdjO7yD5ZTpkpcTXjnzlVfnKp/7XgQLzaObWYyBSFVl50h5aWWRYWotQ7I1geAAJOGRvEAdg7MmTc5lWC1DzTXoxQ5UR58M5shsSirJu7FqRgiVXw3lQFSYGy6Z2WuX8INnKmUYIsW9PtOBSJdTVAPk5LMub7ZSw2lX2h1qLVL7t3/8ZBNS26AGeury427EgBXZxnKcNUj1hixAYA04sQpu12//AQkIYbYcrNrpxUIKBXJgZTCPMCh+DFr/LbbrB5bkLAzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRf1YGHWe3NZIL2XcHQPI4ThFkqMyy4aVw3nWn1FmJ8=;
 b=CsiN539NDt6AUUts9M/WVF0rl/bRi0gIbGwp9aZJpir0JAJC852jnfTt1k+ZnLPTszkvBHwZ+jdyFBb3ZWFFWo7CcvJ/xf3HnRPJCq199apd8CX5vkHGwLW5VUcnGA+Y2GF3PGZNUJCvC0spvMaG3uAE3TMI507JsI4C6ac+af7ZHZpOw9jxrIZJ/7qtplpQCPZh+Yes7ZV2tbpkXSmW31KNqvQ6QdqTnBPZ/sexWwn323ohTAl03n/Y9vsOqjWg1SDmpjeo6fUtTm2S4VbCZKePlIndOxHE28Aw5YQHPUP6OGzZCnGqQGg4nbc85bIquxC5RJqeFy3QrpHZHEFbOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRf1YGHWe3NZIL2XcHQPI4ThFkqMyy4aVw3nWn1FmJ8=;
 b=nRssySiGimqdvOGOBY5GzBUUimwdP2q4CnD1C7JuWv7otEyKVZg+qU/s8dlY49jnZ1Puh7iinuizvEeiNaHYKXdPt5MopI1C1k49Vr8qBlNbG1Jcdr6a/+rhov8mr1CR3ku1IKMsRmd8rNPtprqVac7pKPCFUPOEH5KwmyKdWTw=
Received: from SN1PR12CA0092.namprd12.prod.outlook.com (2603:10b6:802:21::27)
 by DM6PR10MB4121.namprd10.prod.outlook.com (2603:10b6:5:21d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 20:31:26 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:802:21:cafe::a1) by SN1PR12CA0092.outlook.office365.com
 (2603:10b6:802:21::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Thu,
 19 Feb 2026 20:31:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 19 Feb 2026 20:31:25 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 14:31:25 -0600
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 14:31:24 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 19 Feb 2026 14:31:24 -0600
Received: from [128.247.81.19] (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61JKVOUI2694725;
	Thu, 19 Feb 2026 14:31:24 -0600
Message-ID: <b330487e-0564-47b8-95a3-c6c207964056@ti.com>
Date: Thu, 19 Feb 2026 14:31:24 -0600
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: m_can: set out-of-band wakeup if wakeup pinctrl
 exists
To: Markus Schneider-Pargmann <msp@baylibre.com>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>
CC: <sebin.francis@ti.com>, <d-gole@ti.com>, <vishalm@ti.com>,
	<linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260213-mcan-out-of-band-v1-1-af68d4c570b3@ti.com>
 <DGI13PI02XEN.3MNAWATF73XVL@baylibre.com>
Content-Language: en-US
From: Kendall Willis <k-willis@ti.com>
In-Reply-To: <DGI13PI02XEN.3MNAWATF73XVL@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|DM6PR10MB4121:EE_
X-MS-Office365-Filtering-Correlation-Id: 86e03d68-eeed-48c5-1716-08de6ff5da50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dllBWmc5YytSWUdOMkRjUktCMlhXcTlFL052UEVlalJEMHUwcmxiNU8zNGV1?=
 =?utf-8?B?RkhjbVJPNERvKytFczhSSkZvWGZxcWozMFlpWEY0b2tEWkF4U1FCenREQU9V?=
 =?utf-8?B?amkyT21OMTVMRnowTkwrOEx2M0JCeEdYVzBudzk3QXJPOU5CR1I1VGNUWUt4?=
 =?utf-8?B?RXd3OWJVZzJoOVpqRElUY0FnR21wWVFNSjBESWREMXgwWWp0UFlKNW82V3FK?=
 =?utf-8?B?QlQrU25oRFZYcGRUam1DdVlkdFB6Q2FqamlQM3luaE9JZjZEVjU5dVd5SU0x?=
 =?utf-8?B?Ty9Ialk3QTNwc1BtamcvcXJHbjR0U3pYMmJsV2dXTzU5YTBHbEFicFRQdEhJ?=
 =?utf-8?B?dm8ra2xDbW93L040Y2JoNlVuV1dTWnpzODVBZ0h4N1ZiNVBSUERqOE5RV0Js?=
 =?utf-8?B?b0pDVzdKMnFzRVlPb3dLMHdtd1V3WHVMYzVZakx5WE04WVErMjB1RGZwWVdl?=
 =?utf-8?B?ZWVpVVl6N2F0U3orWDBvTkFQSDBVclV5RDBLRFZhVUVBanZ2aWFzc1lXd01E?=
 =?utf-8?B?U3c1ODNVMmdHQnJqUHlBWkdzYmh1S3FSU1B4ODFUc2Y0RWlJNnBpVU01UXZZ?=
 =?utf-8?B?dkFBN3k5ZGt1TTBJMFAzUGhvOTN0MkE4LzN4MTYxWHpRaFlMS1dRY0xhUDFl?=
 =?utf-8?B?VjYvMjZUbDhiSVhxTVg2Mk9FeHFHaVJrTHhHOFl1bHZEbFFHdWQrMmdjQVo3?=
 =?utf-8?B?QmoxVGozeXdwVGN3TGdDUzlsR0w0SWNMNGFGK0UzRG5SM3I3RDV5UlVkMnVm?=
 =?utf-8?B?bEFDVUp4RktvOTZ5OGRtVDhWZW5RWmlMQjlGMVhxMzBQckJxb2NTUTFuU1Vk?=
 =?utf-8?B?b2Rqckg0MndSYjN2M2RCTDBtRzJuU1F2RldwZyszR2xYck13NmhJZVNyakwy?=
 =?utf-8?B?V2IvWlN4dTVZSFVMRUoxOEhIUGgzU0k3cUhTZU1JeGk3R3JJZFJuTnhKRXlw?=
 =?utf-8?B?VHE4d1FWaDc0OGJYWUxBY2tuZ2l5a3FsZy9mOVRNZkNIZlgxZk5XeGtrbkRP?=
 =?utf-8?B?TEp5cExJMVhjZ1NTWkRzOGlwV1V4eStubHVRSnkvZ2xXZFErVzg0NnpodlRr?=
 =?utf-8?B?QzZzcHdGdU1ST1MxdmdRaWhvbmNERlkvOFFhMVJHUkpPMTNYVStJbVptZGsz?=
 =?utf-8?B?djhHbHNlM1RLV09sR3pod00yblN4OXNNeHllWnJyYjVJNnQvSkN2THlyWDZK?=
 =?utf-8?B?WkpLOFFZZjB6cnQvakF2ekp4cEQ3Wm5BV3lFT21ES0ozSmhBS2RqcElpdEdE?=
 =?utf-8?B?RFl6ZTY2SjRiT2srb1NXOHJCcnhSNmVUR0ZYYjJVU0Q1WFJPZDRobHdsTk55?=
 =?utf-8?B?Mkh5WFU5TjV5NlZldXZOZmpWSE1xS1RPQ1ZrTWRnMER4OUtQSisvTlhlMEF0?=
 =?utf-8?B?eDErTDZONzl0ajN1bHFCdjUzOVJ0SDV5NWVKK3JRcmlwVHlYQVVDOXp4ZUZX?=
 =?utf-8?B?V1pPYU1KdEdzZ29qZmd0NERlcGwzM0NGbXpEaE9HZy9ESWtTK1hoZm93Q3Rk?=
 =?utf-8?B?b2hnNk9YU0c2NDJMUmRIaE1jTGYzNjJTbmtPcGlCZ2NpTVB6MmtqekV6UDVM?=
 =?utf-8?B?VG1yZmd5amlDUk1aWTFNdGkrVEh2MW1FUGRwV2JwTmRsaDBrSDlEbFZiTWp2?=
 =?utf-8?B?Wk9yajF0TzIxREk4RHRSeVFSRGZJK01IclpjdDdhK0RsL3pMcER0OTVKM1Jj?=
 =?utf-8?B?ZWdoU0paaS9XK09DRHNWM1FBdEFqZHNkQ3hMblpFL2RCTTljS2JOaGllOHZU?=
 =?utf-8?B?MnF2U2s3ZUg3eTZXV1BzRjRGcDBCTEp3U2E2WmZ1ZXZjS3VZb1BqRm03TW10?=
 =?utf-8?B?UTRGYis1cjhQOEk2WWdURjQ1M0RqNG00RWRNNU52TVpnbFRacWJFNDJYcXNw?=
 =?utf-8?B?WTMvK1VUQXdrMWJuUVVwc3lxUTN3Vk1ycEYxSE8yTlEwKzF1UlZpMWV0N0Rh?=
 =?utf-8?B?dFlmd3NSVlB4Z0pFcHhxTmM2bGdxTHhhbkl6MG5GRWVwUzNDRkUrZnFoMHl0?=
 =?utf-8?B?K01wNnJuUmJ6UHVFek02Mlpvd0c5WUJ0TEdtYUxUUk5Jcy9tNnNQVjdCMUJo?=
 =?utf-8?B?Ym5qSG5kb1pQdFdCYUh6d0daVGxQVjZCaFR4QWFPVkdkU2pKQ1ZZLzl6cE1U?=
 =?utf-8?B?b3d0MFFBVTNaVHFmYW9VenU1OHd5cnAzdmdkWVpRN0xJTWduaFN0amNiV1Zh?=
 =?utf-8?B?WU52NW1wdHNDcjgvQXM3aU40d0pTN2YxWHhJa1lhZmpOOGRDRkF3OHFkSW94?=
 =?utf-8?B?OUZrM005Rm81WTltT3YvUnEwSnR3PT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YSy5BWwCstzmPHHSmuwB6ttSnNSboPtiU849vUjn5I9RmMlYqSTA5iPuWDiFsv6sMfVvvbi3M1lV3fO283y6P1vNkFwkKidrRWk5BJbvDNBuC+7V6DQgcLC34lZwegzp42ix5h1xqHPiI+po5DaCvsdmu8/ri16W05pynBmtQ+A0kbvLvtjVp38XEfOtQzJ6z6FNKv80bkBr3PFRDwJuSPdGuwtj2YBvoEJmIIHlOetEYCY4LNefPWc7VU1G43ma0oe2Uble/mJsfYh+Jy2hMr91VZgr/Ao3o4MUYDmc0weUy0iMEIhLOj7+BO1qbkJY4JQSDhPEKpbSXrfJxVTytF5G3V2AHa1cY6iULuOlUSYmE/ZQHGjWvS16ALfXcn6GHW8HaofRF8Zl5EVTLVJ3p//3cSg5A++HuvXbJTY9UdAGdmVZpxkYGzfkxypJNoqu
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 20:31:25.2792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e03d68-eeed-48c5-1716-08de6ff5da50
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4121
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-6604-lists,linux-can=lfdr.de];
	DKIM_TRACE(0.00)[ti.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ti.com:mid,ti.com:dkim,ti.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[k-willis@ti.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 4811F162552
X-Rspamd-Action: no action

Hi Markus,
On 2/18/26 04:51, Markus Schneider-Pargmann wrote:
> Hi Kendall,
> 
> On Fri Feb 13, 2026 at 7:08 PM CET, Kendall Willis wrote:
>> In TI AM62X, AM62A, and AM62P SoCs, the m_can pins can act as a wakeup
>> source in the deepest low power states. However, the m_can pins are a part
>> of the MCU domain which is OFF in deeper low power states. Since the m_can
>> pins continue to be ON even if the MCU domain is turned off, set
>> out-of-band wakeup for CAN device if `wakeup` pinctrl state exists and
>> device may wakeup.
> 
> Thank you for your patch.
> 
>>
>> Signed-off-by: Kendall Willis <k-willis@ti.com>
>> ---
>> Tested on CAN IO wakeup from DeepSleep low power mode on AM62P EVM.
>> ---
>>   drivers/net/can/m_can/m_can.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
>> index eb856547ae7df27a844b236a0c1d4498cbb8b60f..8b277f5e208ffa634439b9ea8495ed56f12cfccb 100644
>> --- a/drivers/net/can/m_can/m_can.c
>> +++ b/drivers/net/can/m_can/m_can.c
>> @@ -2622,7 +2622,9 @@ int m_can_class_suspend(struct device *dev)
>>   		cdev->can.state = CAN_STATE_SLEEPING;
>>   	}
>>   
>> -	if (!m_can_class_wakeup_pinctrl_enabled(cdev))
>> +	if (m_can_class_wakeup_pinctrl_enabled(cdev))
>> +		device_set_out_band_wakeup(dev);
> 
> This will set out of band wakeup for every m_can that has a
> wakeup-pinctrl set. am62* is currently probably the only platform that
> uses the wakeup pinctrl setting but that may change at some point in the
> future. Can we narrow down setting the out of band wakeup to the
> platforms that support it?
> 
> One idea could be to parse the supported system-idle-states from the
> list of wakeup-sources and see if deep states are supported that would
> require m_can to be off, e.g. mem-deep, off-wake. I think that would be
> a clear indicator that out of band wakeups are supported.
> 
> For the list of state names you can have a look in the dtschema
> repository:
>    https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/system-idle-states.yaml
> 
> What do you think?

I agree that we should narrow down setting the out of band wakeup to the 
platform, but I am unsure of parsing the supported system-idle-states as 
the solution. Since we don't know how the power domains in other 
platforms are organized, it would be hard to say that if deeper idle 
states are supported mcan has out of band wakeup logic. It could be the 
whole power domain was designed for the deeper power states.

Additionally, without out of band wakeup for mcan on AM62 devices, mcan 
can only wakeup from mem-mcu-active idle state, and adding out of band 
wakeup allows for wakeup from mem idle state and deeper. Checking for 
mem idle state doesn't seem deep enough to warrant setting out of band 
wakeup for all platforms since some platforms could have mcan in a power 
domain that is ON during the mem idle state.

Another idea would be to add some sort of property to the device tree to 
denote the wakeup source is an out of band wakeup source.

I am good with implementing the idea you suggested, but those were some 
considerations that I was unsure about for the implementation.

Let me know what you think, and thanks for reviewing!

Best,
Kendall

> 
> Best
> Markus


