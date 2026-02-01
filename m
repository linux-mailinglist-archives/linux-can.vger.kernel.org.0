Return-Path: <linux-can+bounces-6446-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7uiXOJBZf2miogIAu9opvQ
	(envelope-from <linux-can+bounces-6446-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 01 Feb 2026 14:48:00 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEEDC6039
	for <lists+linux-can@lfdr.de>; Sun, 01 Feb 2026 14:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5C6FC3001FC9
	for <lists+linux-can@lfdr.de>; Sun,  1 Feb 2026 13:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6302E1C63;
	Sun,  1 Feb 2026 13:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EETiVNwI"
X-Original-To: linux-can@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010068.outbound.protection.outlook.com [40.93.198.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28B92A1BA;
	Sun,  1 Feb 2026 13:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769953676; cv=fail; b=tkS4MsmrqG26j9Hj2pZXNkn24ZU0SkfTMtukppfTL6XMK9+eBaA1xKfcqv0pWE8IzZbMydLaczPY/RvfPES0P9IIw24/lyQuB5yqYSqkXU1jiZcUT1fdLh18Xll8S4Wx3zgWzxhib5UucvMTX/iNTQrFMCQo2FKinrm7Q+a8MMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769953676; c=relaxed/simple;
	bh=fxTr2hHOhZ2IxpaFJ9Y1uau+WjTB14DY+fxK8ExmPmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sMcvccD1mLXSdYBB99g0FS3DSc4FFbdZJ1UGrLKEpn3SHxZhXlZ6jHl/bZH3MFA74TX8PhjXQ7VcgyqnJQrUu/slZd7gT782wkZ/Z1/DZggPAkxlxnyY70IsclWqPWZ7hZm+2LZeFC3q24jhdk7F8hTsVb9dPEbx1U27gkMgNbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EETiVNwI; arc=fail smtp.client-ip=40.93.198.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ALcb0yXfE2wLmkF75rM++yZqt4DAW9PlIO46gyYpT+BwpJHwU/2GHQ+MYBYyIK8GK9eW+LOXfisjVTOOJx+EqC96cQc39Q9ZaRkdqhMYZdMuqkwS8mnu03u7NVVxnvYAVxloCUM6aObNnfRPGlc2gPwbADFBR4oiedw14KXLrfJGF0mFKuLiecbHfWK7iB6TSmXk8xsfvagZRHCY5aJyxHqsyMCM+uOqHZ8FGP5hY5LlI6cggxsEofigaBUNGIw2zxWhJh4VsQasP++MnChh3BV9dcLiapyY7DnM5SFbxf343IZjnfJnOswy2XEAfbxy8381JSprcj9BM9J8eEcc3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agBf89IBRROD6ysfsPibFdOQ59o+5sP2yJxzHsSAidc=;
 b=s8MV5VgUX9IYrAOCIuGGU1GHTgMhdFb0f2Wpwfa50EwLatBqfYp2Xxww77xiiqckqmY4N8BYauV/j48Knsz2JFfHdkX+toJHO0vltRdDkthXjlFA/oQKHKRanoXw/Woopjz7fUclZdrNqZ4elPlWOWG2mtK9z4H0TfgrJVGoNQUbLxp9JWD9ON22w9ZYuhpJJVhl/188V96N3dCufw0+ywC/WHcpV9jIltWEsMV6cuN43/A5i763Tw3kIcinjP8ojKQRR1LbV+EzPbrSZLQUZ16CjmKQcKxspahRfoJZxLpX9parAvR75E6oWj/3dC2du4EGlR+oXVatO86zD6pi8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agBf89IBRROD6ysfsPibFdOQ59o+5sP2yJxzHsSAidc=;
 b=EETiVNwIzXku1f7XaFSYBYp5Qf2gLwj8u0sbeYOE2CFk8KykD+VSdOGyoWo89QdMEUJubh6hv1FQL8us7f7fpKup3KF1cRxn9Qq8dzMeRa7AIRYM4EbkyJnuBb/wEMGKutKuUs/38n7Wwp58Ka2UmbJ7m9Pa2j33H/0UFdPhfzhj0hzC/uDJINW5ZPb6urmmusQO/W156LQEn5Wx1CWT7yvX+u8fCwJY7KNxJg7mjltRzrdaklw2xoPRhVwAxYGwNFB16fSHF9Z7uYpglcBxFqcVO2mr188Ol5ZfpSZMRyeGYEpDgHTNBXT/tiMcWK7Bhr0Aie2LLCGEE30tDi9YlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS0PR12MB8785.namprd12.prod.outlook.com (2603:10b6:8:14c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Sun, 1 Feb
 2026 13:47:50 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9564.013; Sun, 1 Feb 2026
 13:47:50 +0000
Date: Sun, 1 Feb 2026 15:47:39 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Petr Machata <petrm@nvidia.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Thomas =?iso-8859-1?Q?M=FChlbacher?= <tmuehlbacher@posteo.net>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH net-next] net: remove unnecessary module_init/exit
 functions
Message-ID: <20260201134739.GA114183@shredder>
References: <20260131004327.18112-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260131004327.18112-1-enelsonmoore@gmail.com>
X-ClientProxiedBy: TL0P290CA0007.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::11) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS0PR12MB8785:EE_
X-MS-Office365-Filtering-Correlation-Id: 0782ac62-5613-4d01-37f6-08de61987d44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zBm4RnvaIUsD80pJ1FlwZp6ref1wpxddWJ7TfAzLN47pZR6RlWV2IR2dpc2U?=
 =?us-ascii?Q?jNyb9KptKe7h5ZqsxcKqKc7gO9REKOhSur3z0Ghe6hNyX7ThVnXCEfSUhV+Y?=
 =?us-ascii?Q?lO7z7kCjb5/zGHkyrOOJPiu4sdsy46hHv9pFgBzpYTY2Lx4Mx7P4Haap4ZDu?=
 =?us-ascii?Q?D3NrmiajuCeu4gabEsv5b+x9MZbfXlgg1B5/9HKcdj9UZZujOr9TnHGrvqoI?=
 =?us-ascii?Q?xTH6ZGZmsJIkWI/pXBoTjK31hvsOkJZlCZK2XJZKUBwAcBLWY6EbHrEnBOTg?=
 =?us-ascii?Q?UQxzZOK5abDcYR4nKoyR+ZadDR0R6/oTvOdoMX7gRBYBHcfs6SQ3VpiNcKp5?=
 =?us-ascii?Q?CR8C593qHznu+dM9V1NRsyExZZIoXvm7feJS7N0ms2PTaVpAxyO91qMJmIWE?=
 =?us-ascii?Q?t5ABYZ3t2dGZZl259HrzEhENSzwqEnKrcEsPsKS/qM9UWfIm4cSBvknOms9z?=
 =?us-ascii?Q?1XVBqUEfubiKNfBWs6qnkel5zxoGpoNUTdHFRY79zJ0aXlwatd+mlU2ZfW5q?=
 =?us-ascii?Q?CkTHpUdsA0oIQpxMaQZ/zLeRfDhQrESwuXASgBYGEKyGUdyD2XvZV6b3m/TS?=
 =?us-ascii?Q?XspfX09p3t4Y308Mv5uEi+8NHNARkQ+CeygQ9kPvZuu8ACQiaGtzLy2I8B5Q?=
 =?us-ascii?Q?XlA31Gz8GBjrX8Yq/pTUL4bKbG1qPHhm/JdA+zJXK3mdpR9NU7P85Gl+zuvg?=
 =?us-ascii?Q?rkr1N23E8wQgibVV32nk9XV0mH3tIi1QUxYxqFjo/EmWRnBIGT5OLq4jn0KX?=
 =?us-ascii?Q?OZiKLqAvZrt+341/nQnfDEyNi2TmC/BYyJvtVzSwBF2J6wXTkjH4Bktjktx1?=
 =?us-ascii?Q?kTA/EY1wl3YeFT4vZyu0PmrHJ4SXCh1XZr97E7OFMs76wfH3fVmvybC4phc6?=
 =?us-ascii?Q?fe8LUnQnr0/wC5wy+irYnGshcYLsrUruKOdlnjNA4EdnVgdzfFyiFEihHMFc?=
 =?us-ascii?Q?xneSaTmnv0RGpmpzPpFcLItHjYKToPMTT9iudnbEIWQUkdDdDSQK7jnDQZ71?=
 =?us-ascii?Q?YKL28G4XIFN5J73WG1KrxHAQjcPbsLl7lbmYMkcBHkWP6F8AvIoP24p33VFI?=
 =?us-ascii?Q?/ey606nHx3Qo10XYzAuo6LJHFuvToPE7NQcd01CwjSgzoDV11ZmMmkbKYSc5?=
 =?us-ascii?Q?eZODCIEfmmyPjpKmKEb/kJdlYAGcKyD9nWEGPHgC62e9sA8XASFVzi2eEq7W?=
 =?us-ascii?Q?OwOT/LLn/eFCb73iwdHUpisgPRjgYqxMtRKWFmMa8+pIBaiqvikPYb4hhfhK?=
 =?us-ascii?Q?agi5z+YD8ct9fbqB97GygnZYD8oZQiHCAeNz1Ij6lD4G169QtvYYUyA+ihr5?=
 =?us-ascii?Q?H/0Qn4X2lFrYSW7UTaNKcrCG1haCABPnMvcgJs2ptii3kLtXaJQ77GqiqmEa?=
 =?us-ascii?Q?MPtl46oRGwIQSQ/OMBoHHp8HZ1a3rNjiEC+qEbhr/EZleIF04Zmxmvj5Xe2Z?=
 =?us-ascii?Q?cL53+9QAkYWthNSu9eAS6PyZuUiGcJosQ2ed2yYOPYuOPXgMVUSz1SjUx+4H?=
 =?us-ascii?Q?cP/O6h5m/JMffKzObEG0Iu89onAYx6pFs9++fKMCxTJb029VVbTjQU8MtTlN?=
 =?us-ascii?Q?qTW8OwvcAOfDfwolq1Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UcbDULvkpV1zMVFBoO8cBwWEPwqVsrttRD0oexnLg8NpaD9vTNJRDxA1d4zy?=
 =?us-ascii?Q?IgbLXS1op5dIGpnmTknFf7cNDVyUC1RMicIJ4VBfRIHYSg//nK7VYBlvSInb?=
 =?us-ascii?Q?qyhSBe9j73/kOfTV0053hkNISm4EFYy+mSqST9wGFnzLh2+2enIlYa/3/qCA?=
 =?us-ascii?Q?XZKL0pp4v0j75mOeWL/Wg3CgIiqNml1AxKyrfbPJqSCWM2IM/bWAIPFCMxV6?=
 =?us-ascii?Q?DNiBkGlJcbFDv1D4jd29GUtACTxppX5cb8WgHNSGmqltdElHZLyrw0MtjM0T?=
 =?us-ascii?Q?8XPG3TsHlmtoXigIhAiCLxEn6O3WNFMsS6tPLn0YDaMblQGhZHl5fFmpqBtz?=
 =?us-ascii?Q?kpf0hRl8jdklmhQ8ajAe5ryR8s5GFXBfBFy94XgN/7mM+l50BCEczvFicS0C?=
 =?us-ascii?Q?FogvO+2JQrm2OR7Xa6rS8MnTG4hRERST+oP8zawyZO+WsPNkFLMDcyZohi3+?=
 =?us-ascii?Q?fN8Q/7Vc2PMrlzYAGpGrPzRiW2nX+KE3Wf0Mv+5L3U2s3dJPIbYS2ppjJPR1?=
 =?us-ascii?Q?OiOva5kyWgT+UsmGnejOWKyWtf3RUMy8Vq50ePLesQxKJajEGX94rhYDfrBW?=
 =?us-ascii?Q?Uh61++KkIgWwy8ULzKJnjiDQpwOvXSOYJeZIeSQpAZbL0XdXQc8+09+AVfCx?=
 =?us-ascii?Q?ENlaancCdWtOGZiUcsBHjms5gk1Mv7nvYyKjUtz6iTI107NMkds6nt7A+qvN?=
 =?us-ascii?Q?vyN7LNzMyRCxCaMFdyoNXn+0ik6j44QACKk1QOZnsPajVvEJZutPQQo9LU2O?=
 =?us-ascii?Q?6vncfhi6J5Gpl7vOxEHoX1Ipo7lvHUGp8h81GdpTNSCWWNe+lMqvKxkJH85q?=
 =?us-ascii?Q?9t7LcKBLDl+p8mq0QCYpwQv8XiE48BZUd4MfBDMmji/hE64eP9KvWxhCwl7Z?=
 =?us-ascii?Q?AtgrUxlcExbVeFL2M2EFpd2zB9L5wJYnQd5nw8P2zLTxaMdNxfhMqWQofyU1?=
 =?us-ascii?Q?SC3iuOVrQJu+qZowdp0p9Kl4hvXIr+w8DG7/s8p4Xytn5DzLs75/TiH88gFz?=
 =?us-ascii?Q?5O6eZAj51lk8xHysP+Wzj5Romq9yJQOQNCYigCSAj2BVvUdGApsvwK264axa?=
 =?us-ascii?Q?Q8W27LNRGq4sgMR7jRm5th1rlCwHkCgySuF/8bBeDek7QTfXS6pIsWtadFYe?=
 =?us-ascii?Q?n58VKq5JfE3DMeYwZZkLsxyWiYVbD06YE9vYBRbA9El7r45eHNhI8GFJzXKQ?=
 =?us-ascii?Q?HpY2JXQowt9RS8crpaYwa9vY5bcjsJW9T41peoujxaRAYeadyEIF+Ty2GpQu?=
 =?us-ascii?Q?KpqczXy9iRPWiVeqp0gIEHtdd3tuF9BXMFPgkKrjBp5AGXtB9Me/sLJPuP+g?=
 =?us-ascii?Q?W+gNqHivkaSmzkm2v8zu3XEI03yPd3kf2R7/+UykdZ3nSQq+zW1/Q4jA2hdz?=
 =?us-ascii?Q?0ZOJqvYzMe1rp1CM6tJD0ODO/N8cWzXRjYbA8vL35x4f97v+C2cQHGfRYUG+?=
 =?us-ascii?Q?3Qec7G8FmqFpVd0nKuA+OCU/v4H3JD3Db3vLlwfRVw0cX5JmaAzA9dSN0yx+?=
 =?us-ascii?Q?J6FARwtzGpAb3myXhxMFtC4lzq/UWpnqIsCtHX/7EyFJWLSeFbUP2PVPiYKC?=
 =?us-ascii?Q?MvWipHrq/V0RM5KBo0Y8vBVKu+2dt9M/0DrFLuYX9QPecZ3D0LVPuqYdm64F?=
 =?us-ascii?Q?AqII8HpV7yC9Brq0A+Y8PRs3q847Q6Yo9V4nioAgSSXhWc7xxUdt7KBr2K7U?=
 =?us-ascii?Q?6fz5fmxgqSY2uzX7bEg76gqSs4TujdvbJ40Pf3GoE3Bmtj1C?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0782ac62-5613-4d01-37f6-08de61987d44
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2026 13:47:49.9032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r3xw04KgdQY6JI3kM9PTJ1MjJpCLTKO7UD/WSJmgf1l3ZILE1s1n/SYvAbjuE9rYzURo143ijjeJwDa9pWhdcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8785
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6446-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can,netdev];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 6AEEDC6039
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 04:42:56PM -0800, Ethan Nelson-Moore wrote:
> Many network drivers have unnecessary empty module_init and module_exit
> functions. Remove them (including some that just print a message). Note
> that if a module_init function exists, a module_exit function must also
> exist; otherwise, the module cannot be unloaded.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

For mlxsw:

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Thanks

