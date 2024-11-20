Return-Path: <linux-can+bounces-2127-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D72999D3648
	for <lists+linux-can@lfdr.de>; Wed, 20 Nov 2024 10:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C99F1F21A2F
	for <lists+linux-can@lfdr.de>; Wed, 20 Nov 2024 09:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D3118952C;
	Wed, 20 Nov 2024 09:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XzKeoxAg"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2049.outbound.protection.outlook.com [40.107.21.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C6D19D078;
	Wed, 20 Nov 2024 09:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732093316; cv=fail; b=mqR6juMVr/zX+0DRO2zb3y5EnZLx+UzfTo5uhpJCfUMDz9/RO1FuLTq8+dCQZmVN5+Z976Zc5N0ViWesASuoSmcqotQZ/QPKV3N9/XuI11plX8+o7TxACFFtGFfXp/a21tAwwhXjIzc3kcgQ/aM6/MWYj/634pv2k3aYKy+ZL1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732093316; c=relaxed/simple;
	bh=T48JbxA3OFCwoM4ZQmnfxcOMvYFTPVbydVSav/iNhVY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b3WOmwKB2SFTdS01cJV7xDWyRp+RE1d26tTrcEUYFIbCcINc3mGK98OZUfA4VzPT2E7K+yg7RWEEpNLoJIppIEvdfl6g0lGQ6zVnK8wxUAiYRFX6bm66NQPfP75uj/XnQsXHj0HJg4FQ8BwW82mxUk+oYhJkYCL3Io+w+JtSop4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=XzKeoxAg; arc=fail smtp.client-ip=40.107.21.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dKLHFaym6KxWe0DURITOpAukXsJZfg3346RdvITR5V7kD4eGF/wXTLH8zbvgAba039stXL9NGaSpu220FdFBZKCKv3svW2YQMrAdDLWmKT7RGnBFc6kuMZTDDkeKm1LIQEaVSsH2nLc0H/SjZlpq+PzAlCa4HI9nT6C+FQuBTPykJRBq77ijMV27nBx9aaMHRBxMBfkgUPyR2TZfr0XNxmmnjCyJms6HUIly1SuEBcSUVQzEWjcNm+BOzXsnU0Nu0m4EfEaKzjJApWbnS5ODOWyJkMp4HGT/QxxNEUBxgmuBBBAKRqr5mO+7v4dSBXfSZ2uEK0nasQHyJUlSxMAhNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9rgLIJzo7Mrh5cEeWYs6ENvr77lxc3QtmxiPW2rfiA=;
 b=y2VH/RkAzxsMLBJWpydHONworqm1nD1YUcgvYqpT033cb59N67tZl3EiuKOr0N7aT1bBKGpJRi120M9QlLHmiO4kmNoWwtiu5iRDfk6pOReGA1tK1WN6ngdxs861lbZUVRoWlDR3NeLu/18T9/9HfGntUSSjJDaUGMnTcZnP/+ws82YHNhf357cntTOQMxtAfZXrgsksKZxVwko21JBrRuOK/QLwxKT2hEYWBwmgWhyCVwI7HWo+aK0+eYmVZif6HtYCQp7/lXuAlI6vxBDUsTqMAn9/I48XIchNYBX48SRZDYO4GVlTS0ck6Vwlo26QSPLFOk9PtTP/i2z4GWKgVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9rgLIJzo7Mrh5cEeWYs6ENvr77lxc3QtmxiPW2rfiA=;
 b=XzKeoxAgSFYFDC7E8SEtE/14QOvryb3L4WXljvx7XUoAacJHNl2hc8e0XEhsb9uplLhoQPC+BngFUzJdczTVAI+cA5pvDcx1TLMEYrllrmbCi4EWN4DvK2fshfnET3E2taMFQfhQDuju4quvjAOSCJ2dWun/WDJOinecXd/REgjJ491dV6UFv0dzqrPUTjfh2fU9n85bB4Vo1qks5YAKC4IsY+/Sar8qPG5SEQKGuojH/HVPYLVPaSbJdcC5gmCCVLI1o5nWb9VI2v+fFzkANeFlY104LOir6QeH1zqflQlakcJpyyZ10KM+g76RJz/20SiC1+kGD2BbfdK4Lc9e+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PAXPR04MB8751.eurprd04.prod.outlook.com (2603:10a6:102:20d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 09:01:48 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8158.021; Wed, 20 Nov 2024
 09:01:47 +0000
Message-ID: <c9d8ff57-730f-40d9-887e-d11aba87c4b5@oss.nxp.com>
Date: Wed, 20 Nov 2024 11:01:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] can: flexcan: handle S32G2/S32G3 separate interrupt
 lines
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 NXP Linux Team <s32@nxp.com>, Christophe Lizzi <clizzi@redhat.com>,
 Alberto Ruiz <aruizrui@redhat.com>, Enric Balletbo <eballetb@redhat.com>
References: <20241119081053.4175940-1-ciprianmarian.costea@oss.nxp.com>
 <20241119081053.4175940-4-ciprianmarian.costea@oss.nxp.com>
 <20241120-magnificent-accelerated-robin-70e7ef-mkl@pengutronix.de>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20241120-magnificent-accelerated-robin-70e7ef-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR10CA0001.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::17) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|PAXPR04MB8751:EE_
X-MS-Office365-Filtering-Correlation-Id: 994f0bdf-9137-4a58-b67b-08dd0941f6dc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cm1wOGIrZ1NRSG5Ja1p5a1lSVkFiYjQyS1NvcmlNNHBVL1VscnhpK1RPZm9v?=
 =?utf-8?B?UEw3UXBOV2ZmcmpNVEhLemZYVFhkMEpmbVl4OWZKdVVZY1ZPdC91eUx1TzB3?=
 =?utf-8?B?ZVJlbGpSbHkyNm9EYWpGK25rVGZuZlNKK1dsUElIR2luYzU3SHlMVGdCbFVy?=
 =?utf-8?B?OFJFNnVoVktZdkkzbXlXMWlXMGJxQXQwVUJTNjIyTXN0eHQ3Qmd2K2J3NDBz?=
 =?utf-8?B?eGZNc1ZSNS93em1XcUJHM0hERmxFSjlVUkJXRjR2OW9DM2hsWjVoekVXU1Y1?=
 =?utf-8?B?OW1SNnNxbGZ6SE90aGNkOExyM01sVnFIa0ZTUjBKWEV4YTJ6Q2p0aUFQSlVL?=
 =?utf-8?B?NVlFempDSnV1Y0ZuTERvZ1lna0hjZXRlMDd6aWk4Nm5DdnlqbllFTCsvcUQ0?=
 =?utf-8?B?d2hVY1pXaGxFa0g5RTlIOEVEbHRiNktINVV6SU43akp4V2llYVd0QXRvd1Aw?=
 =?utf-8?B?emI0V3ZDV3Zkc04rSmpCRW82aVMvQnJrQU02L2dDSFNmSUEzUzV1dWFxcW9W?=
 =?utf-8?B?Nm5qWjBUTHNaRkZOb1E4R2EvcEUwZzBHRWxIU3Izczc3YjgvK2dJSk1ZZVQ2?=
 =?utf-8?B?QlpBcldkb0hUdGtvRzVVaDFjWm1rMWZsZ2YxMTQ3UGpzbkE3Ym45Sy9YK1Vj?=
 =?utf-8?B?S2VIWHNwaWRzQXpYTmF5QkVkNEpuaGdRcmdQMDNyK2E1ckpQUFZCV3FDUHZx?=
 =?utf-8?B?aGpETk5hUnNBNDZqZ2dBUVh0Tkt3M0YwVTRrc1NhdjkrWDhuZ3pqeW1aa0Vo?=
 =?utf-8?B?NG5KK3dhZkh6cjB5WmppYXljUHdvRXNrMytCUmRYOTI3Y0JibzVRZThlTWJC?=
 =?utf-8?B?cmhYdlJhQUt4ZDV6TlVvYXdlNkFzRG15MG5HdUIvZVNkODFydXkweXJnUk0x?=
 =?utf-8?B?cUpWVzRGeGxQRFJ1cE5TK3kvZXJVL3kxOE9Va2VjeU5WWEVhd3VLbXhKcGk2?=
 =?utf-8?B?bHNxZS92Q3k1cnFoSUdyaHVQNGxFdXpBcUxaQkhrVXJ6QXNWSzlFbE9OQjBy?=
 =?utf-8?B?blU0T3lOdVJUbUN5QXd6SnM1RjUwN2pPM0dNTXBNWXRQdCtzRWczTVRFUlBX?=
 =?utf-8?B?UGRIRitFRVhtSlBVdUZhWmI4dVBuYll0NFhNS1RlTDhuU0ZTQUpUU25LMGxJ?=
 =?utf-8?B?eTB4VEtTVHN3RDMrcXR1YVRkQkErd1dLWHpNSmxxdWduaDRXV0hkWEdGVmNF?=
 =?utf-8?B?Vlk2WkYvWC9QN2FiVEV5QVpQcWtZWE01MzlickxPTEh1WDczL1BPTy9Pc0lm?=
 =?utf-8?B?YU8wV25oRSswOVE3TG5tZEdKeXBaYitRUG5WTmVkVjlJSWNNNEFBNEhkNGlm?=
 =?utf-8?B?VjhXZElWY2UwSWlpU1R5Z0RyaytPenErSHdxOUdVQjkyN2NFblN5MVRiN2pj?=
 =?utf-8?B?L3VhMmZFdzdrK0NsT2p2V2pZdVJPaGJQYzd4eHdXazhTYnJaMkRSSkNYVHk3?=
 =?utf-8?B?ZUgrclN2U1NMdzlMNXk1NmZUUXk4TnFYR0FjS3ljTWhVb1BhTzVqc2Rvb1U3?=
 =?utf-8?B?NUQ0TGhSUUdXUnRRMWV5QWo3cXJscjRWVjE3YTJUS2dqYjB6Zm05Y0pHcTUy?=
 =?utf-8?B?UEJ6NVpJM2ZDZHI3bG9VT1NpMUZ6VnZZQjJjU2FFQkVCTC9FcnBObE1Mb2hB?=
 =?utf-8?B?d25ndjJwek51bUVzRUswcHB3K2ZXc1FxRDY1U2YvL3BoMnp4UFdjSUZUcGlI?=
 =?utf-8?B?b21JdEN4djdmV1pSeTJTRlFGTEhsSGlMZUZhYUdsS0c5dUZIaHgwRXF1VHlq?=
 =?utf-8?Q?kM1xC8mUW3yNUhvWxFZeAOWAitAc0QeMrK1zJnm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1AydkFBSFZ1UzF6OWVuZ3g4N2dScFFkQ2dGQ0hYQWtyZmx6aDA5djZGWU94?=
 =?utf-8?B?aWsxMFFwUmRKN2U4YUJpdjUrQjBjaWNrSUpGTkw0YWV4eCtRQ2VEdkxWVVc4?=
 =?utf-8?B?SU1TeG9GWVJiVlZBQWxqRjV6a080Rm8zSUl4UGREeWJIU01Nb09pRVg5NGxt?=
 =?utf-8?B?U3hOcWFVdTNqZ0ZoTDc3Tlp5NkJ5ZnExTGdxYkgvNllSbXd4RGZDRkZhbGhT?=
 =?utf-8?B?NEpjcHV1a1F3TnN3Nm1lcGQ5Y05wckxEbzM5aWhVMkJ1UGcvaDdXNDd5Y3VE?=
 =?utf-8?B?RmxpenNjc2JySUJhNk9ja1hDdEN6bnNLOVBHY29GbDhXRWI5WGxpUlYwMnlO?=
 =?utf-8?B?dHpldXNpd1VrVWRTazhOL0c3dHlVV0hMVmJlZnltbkltZnEwcjJjaW0yQXYy?=
 =?utf-8?B?TTJZaHY5a3cwVjFmNG5RTW1pVktiNW4vOXd6VEV1aFdCNjhqYTlJc0VBWDV6?=
 =?utf-8?B?cm5sSGpZZ3J6cFllU2lmK0hlVHFwUks0TURQMmVUbkFQOGNNdnkvY1Y0TVZG?=
 =?utf-8?B?NXc3SjBqQ2JDcFIxb0RUeG1OQXFRT1RMeGVicXhLdHFFbTBsOVJkaVVzR2FM?=
 =?utf-8?B?YnFoblZ1SW5RTGZoSXpub2t4WVVERkV1Zk9ST3NtNkt3dnNoeTRiM3F5L0hU?=
 =?utf-8?B?NFRwV0NHTkJoRnZhNzBNUjIxR210b2prdjg3SHZhakxLUmpJTHVzUUF1Q0Q3?=
 =?utf-8?B?L0hGb3NDVXUxMC9qL05vR3dnd29OczBZZTVJOFVyR1ZKckY3aWkzSXo3ZXFv?=
 =?utf-8?B?NVZNV0dvbmFuYW4yVUlJTmVIdXNkajF3WUFJZzNYYjcrYzlCcDFzZTFzYWZm?=
 =?utf-8?B?Rklzd1o3TldBYkZrekhaUVNBbHF2SWdUdzFQQnpUYi9jNGphU2VLNWtjbzFw?=
 =?utf-8?B?UkVNeGxzb3NQdjJYQ0I4b01XcVBSZ1pOQjkyMTk2aUJBQnpPTmw5dlFzRTNF?=
 =?utf-8?B?VnhrajBWZDNWYXFpYVpPTHpNK01VNVFwSkhSRlZRb0xLVndMWlFMU01aRVM5?=
 =?utf-8?B?MkdpVEZaVUg3SnozR2FaV005TmVDZElDendBbWJMaW9jRnBZRHZuTjVIaktR?=
 =?utf-8?B?MDVZZjh4WW1CYmtIK2hheVZWMmJJUEp1TDNXQ3NTSU5PMnFRYjdQZEFUN21n?=
 =?utf-8?B?cGRFMWY0dGZyMkdZdHM2OFlpS1YvK0RUTThQSEhTQ1VwWXNGeGwwZXFteFQ4?=
 =?utf-8?B?WERJanZIcXBpWWRVVWNRZ2hPc2JETUswZUxCNDBqYWpOSnRla2VvYktyVGt6?=
 =?utf-8?B?UjJTZHk4M2VLTGE4a0tIbm1DVjZibGs1NnE5N1l0eXd2QXJlSWVSVjJ6dEIr?=
 =?utf-8?B?TUd1M3pyS3NCdjcwajV0dXM4VzFSQTlYVXJrTHdKVDVlMFRBMWo2ZzVTemNZ?=
 =?utf-8?B?bzloeWpURWJrSTUxeDBFQ0RmL2hsOXkwWEN4ejNsODFYa0F6ZStraXNHTjVa?=
 =?utf-8?B?MjhQSkhrVnQ2WlkrSk5XanN1dFFTNHRVckpqTUQrTVN2U1FaSjdkZkdaUnBa?=
 =?utf-8?B?cEhIZzkzbGFUQXZrc1FOUDhiTDkrWUl2UnoxSzhmUnVVL200Y1RSQnN1ekpQ?=
 =?utf-8?B?bVY2NUkvNjY3ckVvSGdEVExta0FiMDBrRUlZVzAyUXEzWW9oMWNVbFlCRTRI?=
 =?utf-8?B?QUtlNWx5bXk2WGdubktrN3pjdnR3dS9LV3NUNDdxbXpPQ3NrVjkvTkIzM3Ir?=
 =?utf-8?B?bVptT1QweWdBK2R1Y2hVY1g3aUdzUkZucDU2cWsxZXdydjluakhFS1ZvZ01h?=
 =?utf-8?B?UE1LaDNpMkJYZGx5SE9EM2pxMWJTUVZhWXdCSysra1BhSDFyRU9OdkdXNkNo?=
 =?utf-8?B?Z0MrWSsrSHIzVTFmOExBd2FzM3RpcjVqTDFabXhkUDVFSlI1UVJDeFZVU016?=
 =?utf-8?B?ZHdlUnZJL0xxT0l2LzcwcUVqTXJZMWowQlFYb3lZN3NhUWUwRTVVZ2M1NkRy?=
 =?utf-8?B?eDZtTmRjdGJpSkV0VWJrM2R4MU8vRUtYVzcyMXQ2WXpnL01tdnJlMXZqVlRy?=
 =?utf-8?B?WVVLSEpyUGxlZlk1Y3E5Y3oyZVFRakpvR1RLeHhYT3FDR3N1VnE0WVNETWIz?=
 =?utf-8?B?RnpLcDcwdHN2aUhVYkI3MnJKNHpTWDl0WDErSmtHYzA3K0cxSkRxYjlabVJh?=
 =?utf-8?B?T3JJYjJJYWpHN1lVNXBTYkxwdVdWYTdpd295Y2RFYmkzekNsWFB4Yzkzb3lq?=
 =?utf-8?Q?+FWJ+yhuC/t6kswnxh5buHM=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 994f0bdf-9137-4a58-b67b-08dd0941f6dc
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 09:01:47.7275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hN434cyhrTJTEhWpoYDiWiXzuXyfSLdkt7M+pbR7RECaxhtkV8g1vHg1gZV1VlYMyISLs+DJdMZsuw0irJB8q39Uopm8ofweejuQ6eAoFN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8751

On 11/20/2024 10:52 AM, Marc Kleine-Budde wrote:
> On 19.11.2024 10:10:53, Ciprian Costea wrote:
>> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>
>> On S32G2/S32G3 SoC, there are separate interrupts
>> for state change, bus errors, MBs 0-7 and MBs 8-127 respectively.
>>
>> In order to handle this FlexCAN hardware particularity, reuse
>> the 'FLEXCAN_QUIRK_NR_IRQ_3' quirk provided by mcf5441x's irq
>> handling support.
>>
>> Additionally, introduce 'FLEXCAN_QUIRK_SECONDARY_MB_IRQ' quirk,
>> which can be used in case there are two separate mailbox ranges
>> controlled by independent hardware interrupt lines, as it is
>> the case on S32G2/S32G3 SoC.
> 
> Does the mainline driver already handle the 2nd mailbox range? Is there
> any downstream code yet?
> 
> Marc
> 

Hello Marc,

The mainline driver already handles the 2nd mailbox range (same 
'flexcan_irq') is used. The only difference is that for the 2nd mailbox 
range a separate interrupt line is used.

I do plan to upstream more patches to the flexcan driver but they relate 
to Power Management (Suspend and Resume routines) and I plan to do this 
in a separate patchset.

Best Regards,
Ciprian

>>
>> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>> ---
>>   drivers/net/can/flexcan/flexcan-core.c | 25 +++++++++++++++++++++++--
>>   drivers/net/can/flexcan/flexcan.h      |  3 +++
>>   2 files changed, 26 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
>> index f0dee04800d3..dc56d4a7d30b 100644
>> --- a/drivers/net/can/flexcan/flexcan-core.c
>> +++ b/drivers/net/can/flexcan/flexcan-core.c
>> @@ -390,9 +390,10 @@ static const struct flexcan_devtype_data nxp_s32g2_devtype_data = {
>>   	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
>>   		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_BROKEN_PERR_STATE |
>>   		FLEXCAN_QUIRK_USE_RX_MAILBOX | FLEXCAN_QUIRK_SUPPORT_FD |
>> -		FLEXCAN_QUIRK_SUPPORT_ECC |
>> +		FLEXCAN_QUIRK_SUPPORT_ECC | FLEXCAN_QUIRK_NR_IRQ_3 |
>>   		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
>> -		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR,
>> +		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR |
>> +		FLEXCAN_QUIRK_SECONDARY_MB_IRQ,
>>   };
>>   
>>   static const struct can_bittiming_const flexcan_bittiming_const = {
>> @@ -1771,12 +1772,21 @@ static int flexcan_open(struct net_device *dev)
>>   			goto out_free_irq_boff;
>>   	}
>>   
>> +	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ) {
>> +		err = request_irq(priv->irq_secondary_mb,
>> +				  flexcan_irq, IRQF_SHARED, dev->name, dev);
>> +		if (err)
>> +			goto out_free_irq_err;
>> +	}
>> +
>>   	flexcan_chip_interrupts_enable(dev);
>>   
>>   	netif_start_queue(dev);
>>   
>>   	return 0;
>>   
>> + out_free_irq_err:
>> +	free_irq(priv->irq_err, dev);
>>    out_free_irq_boff:
>>   	free_irq(priv->irq_boff, dev);
>>    out_free_irq:
>> @@ -1808,6 +1818,9 @@ static int flexcan_close(struct net_device *dev)
>>   		free_irq(priv->irq_boff, dev);
>>   	}
>>   
>> +	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
>> +		free_irq(priv->irq_secondary_mb, dev);
>> +
>>   	free_irq(dev->irq, dev);
>>   	can_rx_offload_disable(&priv->offload);
>>   	flexcan_chip_stop_disable_on_error(dev);
>> @@ -2197,6 +2210,14 @@ static int flexcan_probe(struct platform_device *pdev)
>>   		}
>>   	}
>>   
>> +	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ) {
>> +		priv->irq_secondary_mb = platform_get_irq(pdev, 3);
>> +		if (priv->irq_secondary_mb < 0) {
>> +			err = priv->irq_secondary_mb;
>> +			goto failed_platform_get_irq;
>> +		}
>> +	}
>> +
>>   	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SUPPORT_FD) {
>>   		priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD |
>>   			CAN_CTRLMODE_FD_NON_ISO;
>> diff --git a/drivers/net/can/flexcan/flexcan.h b/drivers/net/can/flexcan/flexcan.h
>> index 4933d8c7439e..d4b1a954c538 100644
>> --- a/drivers/net/can/flexcan/flexcan.h
>> +++ b/drivers/net/can/flexcan/flexcan.h
>> @@ -70,6 +70,8 @@
>>   #define FLEXCAN_QUIRK_SUPPORT_RX_FIFO BIT(16)
>>   /* Setup stop mode with ATF SCMI protocol to support wakeup */
>>   #define FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI BIT(17)
>> +/* Setup secondary mailbox interrupt */
>> +#define FLEXCAN_QUIRK_SECONDARY_MB_IRQ	BIT(18)
>>   
>>   struct flexcan_devtype_data {
>>   	u32 quirks;		/* quirks needed for different IP cores */
>> @@ -105,6 +107,7 @@ struct flexcan_priv {
>>   	struct regulator *reg_xceiver;
>>   	struct flexcan_stop_mode stm;
>>   
>> +	int irq_secondary_mb;
>>   	int irq_boff;
>>   	int irq_err;
>>   
>> -- 
>> 2.45.2
>>
>>
>>
> 


