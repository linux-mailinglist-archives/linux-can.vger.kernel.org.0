Return-Path: <linux-can+bounces-3371-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAB4A806DE
	for <lists+linux-can@lfdr.de>; Tue,  8 Apr 2025 14:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BB201B845BD
	for <lists+linux-can@lfdr.de>; Tue,  8 Apr 2025 12:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0130926AA8F;
	Tue,  8 Apr 2025 12:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="f+rf7Ewo"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2114.outbound.protection.outlook.com [40.107.247.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E284269CEB;
	Tue,  8 Apr 2025 12:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115057; cv=fail; b=Ij/gfik81WiyXMp7xpEegDdDsgkSlRLgcfY+VumASGa4Ci1Zwb26bqlgl7J0yfr9o6FSe0F8cUutcyZW2GyZzCRsRDvCdJXUTr81tELEyDigz1GPGXDiinzkz0Oe7FHGqM3S6eJ7iw5n70fgSO8cDJIJO0I9YzwyvWrqgC/2FWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115057; c=relaxed/simple;
	bh=dSOGEwWScOZt+xWmGVyAPLWcnserTXzbD5XJTvxBX/8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=KoAV1VXPbDD5sL/wQ72Gd4edsPbFDNparJtuCLNX8rrmMJP93/2uBh8SU0dQ4D/SYLx7zHF/vmFQQ/GO9a3Fd6v0UqjoEBo5CBGWPC9jPTuld50HJ77HfmBGSN22KZ606Wgfgddqu9diTg9Y4Jy7KmC+xRI5Tv/0lXQwSLNvOjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=f+rf7Ewo; arc=fail smtp.client-ip=40.107.247.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uTldOQs8gwSO+x/L/X2/XpYr9Ykp7t1Kva0KrV5PMNQnt1pTabdLRq7Hyjn61yN537cjTAHAsbbbQNroq+GM4eYzS7WT7BqtEzFDqv8t8so8gGEsCM4kZlUypNAb+pEh3P77PtUoDU+KZ+pFlFQULAq+3xJ1+QAV8mcrB1RRgzbUXo9FBpUUz6ojpDhwAchCKVPSeGohYowbe1GWMXvJD+kSPUnif11yhPeKjd6lWutCqTOGvC6KJ8CHi94wrW9W+5WPVmUTa+NI2AL2QuqL0EAbpaMFralmTz8VBSVEWdk8eoAWMDrRzz1YX+/B5mOkpHNvtvsPq2a6Fwnm1R86+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVVTZOMstDjIPF6H66719ObB69J6OotupDD+IPqPt+U=;
 b=Mvp64JpY9naS8ezJIBFgAyE9K9qcql9i/OL4t4rzi+2knjEvESevOwkCq9+kfdQwuKV7FLvZCsPi0z9+7LOjTAWvYUtEks7LOem30dQQRPAR+EKYX7hXxrmAoji0Q9kUBKhL3WBYZYH89JQYdpmUSaGqyQdv3civnm/CcQaMN1jychUTJ2VW+8VSkrPptFWV98l5P2XAfkHbUcu6s+VdPGRfOt1n+Amj/nqgzHLHJEHxs+L7hzEkNDx2g3H2n5t/Tp2nngNyyFPzOlwFL6l291c4mtp1CRJuPxmWYtnoZkk5GgqOyz7bY7rcn7/jHYJY7JESysAzJD4/nOm9B2efbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVVTZOMstDjIPF6H66719ObB69J6OotupDD+IPqPt+U=;
 b=f+rf7EwoUeOoTSFR9IZgCgXw2kpdncKJQTH6CcUH7tF4gyJyJWHYLGzP3zowJ1a/pfQx6N+McBfFgxq129xnZSK4JEV7PgTQAUccJvCMF/m/3/f+JEQ1QwmvSjqeLJJ5cT4SCKpRvRZQTBV2YPhgOtDkwpAr2mtkFITRiYmN6CA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from PAXP193MB1663.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:1c3::18)
 by VI0P193MB2617.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:258::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.17; Tue, 8 Apr
 2025 12:24:10 +0000
Received: from PAXP193MB1663.EURP193.PROD.OUTLOOK.COM
 ([fe80::a4de:d967:751f:55fc]) by PAXP193MB1663.EURP193.PROD.OUTLOOK.COM
 ([fe80::a4de:d967:751f:55fc%3]) with mapi id 15.20.8632.017; Tue, 8 Apr 2025
 12:24:10 +0000
From: Axel Forsman <axfo@kvaser.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, mailhol.vincent@wanadoo.fr,
 stable@vger.kernel.org, Jimmy Assarsson <extja@kvaser.com>
Subject: Re: [PATCH 1/3] can: kvaser_pciefd: Force IRQ edge in case of
 nested IRQ
In-Reply-To: <20250407-unyielding-panda-of-wealth-5c277e-mkl@pengutronix.de>
References: <20250331072528.137304-1-axfo@kvaser.com>
 <20250331072528.137304-2-axfo@kvaser.com>
 <20250407-unyielding-panda-of-wealth-5c277e-mkl@pengutronix.de>
Date: Tue, 08 Apr 2025 14:24:08 +0200
Message-ID: <871pu296zb.fsf@kvaser.com>
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0037.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::27) To PAXP193MB1663.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:1c3::18)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXP193MB1663:EE_|VI0P193MB2617:EE_
X-MS-Office365-Filtering-Correlation-Id: 34a5626d-05e2-43d9-b867-08dd769843cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O9gB0D1QLAXAyxDf0pMpl7wWHvLrr/ahkl0TaQmelK9TF7zcSO2E2/Wc/mrj?=
 =?us-ascii?Q?xWpNWiN2dZ8m/BXiarI3CimsMN6uUUB9DR3u/VYlLknUyfvXdu5TVv2s66uE?=
 =?us-ascii?Q?KqfyAhn+zR6oxH2+qsbgxbfmwrutBl/vfxUVyoZPkfjiPBBS7/PytBpp2l+V?=
 =?us-ascii?Q?UYfndimaGqd36ua5+TBAFuwxcDqhe4+DIvr9HseKUWp9dSoZNjxu/VgRfJwm?=
 =?us-ascii?Q?RVMpsnVW+n8Tk/951gfHJRX8/A0vcfc7JhvhewK5oFBtErOxXYLKAB3DrAeu?=
 =?us-ascii?Q?Gb2NMyOYba8IO6sg0jqEw8dqmKK30TCbFsStBmFlAhgNoOYyn9+WvnFYY4Tk?=
 =?us-ascii?Q?iEBZmSSSthXj7be5eqT2rARw+GKAAYB8h6iQ8HlBB2OEFadXS7VR4CwwJ+Lb?=
 =?us-ascii?Q?ePUXGq9k+721OpP8MA8WsBFyR5Z6wJ5y4oOoFe+ohgOEIIkshbaBgkIUg9Me?=
 =?us-ascii?Q?yUey76Cj+NvFdLVmzqT8PdOdeVB8Lou0cN8hPuvvkBfIZg4YkMsdcH3YQhKK?=
 =?us-ascii?Q?50jzA8cTP7FT6dPaSg4PTCT9BCjJZppwfIiOe44nW7Fdigo9ifDDbBfthNaZ?=
 =?us-ascii?Q?mSfu0znZmOUaxfdi0sxi9rgOzzWRVJGZMcveV1eJX7X7VRf5bzui0jB0qlLJ?=
 =?us-ascii?Q?8O6nG8v1bIFVSeEoWd/THoUCZWayobMfRwQvmsBFF0I/26zLR1s5eGEA09Yt?=
 =?us-ascii?Q?JpbOBR/uNYa14AjqZweEN652e51M1mdsBRjbGIn7CezO5aZi/k5h3C+QOvmB?=
 =?us-ascii?Q?KV9QB98gpLxwG81l+QgRCYMrox78lAZO0YmIgHquF4EMeg+PNprSkSofA9GJ?=
 =?us-ascii?Q?7okOsLSz28zSKDUdt40P7pP7qEubcqGJGLLkEGXg81giUd4cNLNOTxit9DAx?=
 =?us-ascii?Q?bnPsjgsLBkbwCg9l6W6cL8TsQITfu4J2U6pNCOV0pzk1yQRriGvCJPHqSpop?=
 =?us-ascii?Q?WvzcJ0RUZYvGKwyR9QhZlHYPu8LWGqb8ZoxcazPjfwCV9KheY8Slg0OvwNaU?=
 =?us-ascii?Q?Z9S5VsePhQYDu22DQSzZjYiateUF2xuAhIPvh4oJH6WAW7XOXPhjIWAwjdu0?=
 =?us-ascii?Q?8Xq02XsYK9A2o7CbHKA7n1t1wmqOVP56dB8i4hI+eFT2mnDMW73MDlNoUxM2?=
 =?us-ascii?Q?bnEY7W68ORrI1wD4yBwmMBFX24RJGPc6WfataiqJnyDtCkXq2cJXguEmR2jR?=
 =?us-ascii?Q?SeXBjgV3VH7TXWyrg1RBlorbPyNh9z7plB61LdCeO/+L2y8A3DMnkpQTyx04?=
 =?us-ascii?Q?PG+rEFsqGJj0uY0OQ40HxD1pQHjxri1InBwi9kd1Je3QvHbKkJS1d/bitiF2?=
 =?us-ascii?Q?Uyt7Ms6pkZKiVBbima5WrBzHsv85Uq5zBhRWtxBu2Pa50tOalC24cd85AN4k?=
 =?us-ascii?Q?fQJKQc0v6Wx6UYrmMCU7SnfZzIgp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXP193MB1663.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nqpk+ErYqEzp7s9JUob+YvRLOPGGr+QdznAcL9Ss0a8otFlqLbA4RmAIrTHO?=
 =?us-ascii?Q?I59LCxNvBKv518ofBmfOHZg7Rsa64iaDszHyxD9G+htpbkPdTUUwZ+N9SDtJ?=
 =?us-ascii?Q?SDG5UOpo2XWns01Dn4YvsShH2xTZQKwF5ReiMPMt/nv0zz9LyvC5p0MlRMFl?=
 =?us-ascii?Q?dh0ile+zznHEGtkH17OD4EqXGXOslrveuv8vsHam5ZWn29wu9D/73qDAAM2W?=
 =?us-ascii?Q?SAtTmXJLk0cKGkfis/55XpLPoakJteEqSbt5oXofMph9agOxhBvhI7R9kLEv?=
 =?us-ascii?Q?wQm9MTaWrIPCdGlPW/VgrnBDgtW24F2Q4ZmPDSBxVyYAAPc2PswY+G4D9Ct2?=
 =?us-ascii?Q?FRC18qe0ihIQy559N+2R3hJGJVIKbYuI8GvWcK1TXcvW9bvgt5PnYuVF0QOV?=
 =?us-ascii?Q?gJqgTAMcyZmW7KxmKDKddathNUV3QYdWRk0crgzoiTLcezC/tTvzUau6N7MQ?=
 =?us-ascii?Q?Er3fopJ+wuo0o4swqQMjXlAtGYPjYizucHvmChKimXPqicNcPF4/M2ApYPNN?=
 =?us-ascii?Q?3isMGlhWOGi6AJJkNodLW8DbIGsTfzwpd0bTh+u/arpTogbN3wvuPiPHF+RV?=
 =?us-ascii?Q?BAzKqg330/FnsY11PlMHHeNFmhNqufNFQVPN9av1WsWdsb9xsioakDOMYk9W?=
 =?us-ascii?Q?tc/BNv1vo6uJ6M2vTuawV2bkDkdTNXrHdYBA4cQMjxdW+MbXxnCAHB9h31cJ?=
 =?us-ascii?Q?ZHhITQdqa/EZ9a3UYeCnxJcDVTCyGw8k6pt9b+ZmFfQfwXQVUTd4kyekdbd+?=
 =?us-ascii?Q?zV656s798lK4A6IaKZRBJcCsPChABESl0+er9rX+Khf5Ps8UAYhKxElIvbXl?=
 =?us-ascii?Q?M52687kiNHbbTDSynv1GWhhPhJwky0Sob7KKUpsAvtjAnccFalLb84iQB/FI?=
 =?us-ascii?Q?7XDra+WjVuE95dLavW7EN4zt0FCiNQPo6QhzcQzP72mE6w/m/oIIEIM+mW5o?=
 =?us-ascii?Q?yPF1AvZF/qigC3kRdJQUA3g8kuf5VYYMwNOYzCQ8Za6hOEHhnAzklxCtFdVe?=
 =?us-ascii?Q?MnTz32aGbHkffO+kWbEqfNpFtK4QTdIAL9OTUKb5EByFDgDLKGiF7j0XQaHT?=
 =?us-ascii?Q?A7LPHiHdYbIsefWifyteh5j+amizkHwMxW2jiUeC9hUW5SLCTSffppdR20c0?=
 =?us-ascii?Q?Y65JKVdhcedJ057LHzmcmhU172OnW1zS1Lrn0JV4TQWSC09z2WIlcWA4DFnj?=
 =?us-ascii?Q?USc5d7Pxnfki03kXMvLaE1Mxg74kxQl0LOl6goajRCndtAG/iFnAuxJ1j7HK?=
 =?us-ascii?Q?7pO6FkDyd3zWORfWqRnDNtUfC6+53B4C7tPlRT4HUG6G89CjhyEKkVLouSnJ?=
 =?us-ascii?Q?67MwIKQJafmU6OuEw7JCrqUMturycThUcUctCulnZdW65q0HgFOdt7P0V1qW?=
 =?us-ascii?Q?+ZfgYASxY59XSrBo8ca/zhrjieYUdHMMNiStQRVlswef0uSWi1Y0UXBR3GL3?=
 =?us-ascii?Q?s1DBGto4Oc7dX+lQRIV7487k5dLhXcOw/gzqCjxe9yMkg9gohPFpbIIH/e/S?=
 =?us-ascii?Q?EcwbkpPaw5rMLedztNIulC56piVlvDCTYQVNYV8S2yhFu5uq1CKQL4Wg9QNP?=
 =?us-ascii?Q?h3WUqUdiL1p3C3rAx29uQkukVB/WGhLpuxRpyf0f?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a5626d-05e2-43d9-b867-08dd769843cc
X-MS-Exchange-CrossTenant-AuthSource: PAXP193MB1663.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 12:24:10.3031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JKXVRLRkHgrTYleOmx7LCxXFAPPYif3+nUyA3tryYWtD5IUzdJzx4JJGnXKx3bPjIHWGph90ZoX/TxzuLDKT4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P193MB2617

Marc Kleine-Budde <mkl@pengutronix.de> writes:

> On 31.03.2025 09:25:26, Axel Forsman wrote:
>> -static u32 kvaser_pciefd_receive_irq(struct kvaser_pciefd *pcie)
>> +static void kvaser_pciefd_receive_irq(struct kvaser_pciefd *pcie)
>>  {
>> +	__le32 __iomem *srb_cmd_reg = KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CMD_REG;
>
> Why is this an __le32? The struct kvaser_pciefd::reg_base is __iomem
> void *.

Just as a hint that the register is 32-bit.
But you are right, I will change to "void __iomem *" for consistency
in the next iteration.


/Axel

