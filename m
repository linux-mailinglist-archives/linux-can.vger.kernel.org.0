Return-Path: <linux-can+bounces-7439-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BbMJAA582mFygEAu9opvQ
	(envelope-from <linux-can+bounces-7439-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 13:12:00 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8474A186F
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 13:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 26B593035371
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 11:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C09C4219FC;
	Thu, 30 Apr 2026 11:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="luEFMh08"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011037.outbound.protection.outlook.com [52.101.65.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CC6421899;
	Thu, 30 Apr 2026 11:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777547244; cv=fail; b=RXij9mVIIpjLGA6i89BAOe5phNkOPoFy8infk/QNMSTbXcr2bBSFiwq+TR7tLvUYlc2wx42EQtkl0F7XMXMh+sIX2KWx4Ov7kgqx/pZu4SpDtAYOHkllnPKB1DORmr+f096++OVckLWdZ9y9dje6lo8Vb5uEzXMNWxOx/9tuMqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777547244; c=relaxed/simple;
	bh=LsBWpofgUCRBw120uSaC3S0Yltf2CdipULq6Q0pXlK0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lzg7rnqo9OTz8yJjaI97JmdzMKi4ArhzH9HMvzU2WHIlXTsdQ7r+WTPS6UkOPkJje65DyjRa0oiSWyMeP06NOwj0adZTfEAeQboTkQF6YUGAG2Zfg7uKCxXlQ6lmu2SJYAEIhJhgeROMf0v4KMIDdSJABno3Lbo/1yjEawJCZO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=luEFMh08; arc=fail smtp.client-ip=52.101.65.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQN4d5/t+0dnO/HV8mziqA+SJhNAnze8L8jXXSG8gqCEniMQnyClurH0Em4icf0k38OARw8QyflJHqFAnM5+TZJLRz9HJrEh4VNFq4JWxuvR/IWvPiQ1ISJb/BxXfHugtLBu5g651T5bDGSEVtT8g/2G39gQTTiX4cJ8yHnueVYrDyLNKnQ44oOYL86WrX5sE17+5hv36Zri4KiPfbpBEruxvADxSQ+loEp14i1pxHwazlNrnS6Mxn6aCqtJ+ksc/wxskP29JCxt8dFSOjsZoJg7HbSsBezfD3L7uh+wsXhQPIeIz4P6/M3i85fcbucWXTJLJ6KFq5bxYG4fWmt4VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njPr2CelAVpsPef3LdMKU8MVjh31mvKYj6jz6cuixK4=;
 b=gtQuQGmuMiMdrqKGFIgoQdpM0+imaulFoXqSJlZKbmPFnySjNGrZBqa518PbM27WelJjhHzLX/42InHrGnb8mma+aL+esXzNVFrrCgb3K67DQNNvvGom20vBbn1xiGQRFtAQ+q0Av4pf/H7anNNTdPEvaPWswogM7qvJJAjcUCLPTO7sS71rCqb0jdXrteOFSQPoCb1TSw4Z1wtFWdF7/N9shgjV+LDSUoae/vUY7xt9v/ZkTJaRFA+W8MiwcVIoQLFlvzNJyVZlkMqMbnZcFsk9qMy4/67VZKfNsYszo42/4LdGtDBadobZlRIkWDXpo5FQ7eLzLMbw7IPMBBQs1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njPr2CelAVpsPef3LdMKU8MVjh31mvKYj6jz6cuixK4=;
 b=luEFMh08qEVKqbQ67QdPVv49PEP5On8OZm3NZyYGW78SfUjyEqLXaCNnKGW9a5HXHVIIdlscew+XrBErvzpIAtQkpfj+c1/GgKKIUdj7f4wRjx/G7HPqZLwE9BJOgAaS+dQCik31zSCJVoS5U+zxX7W9cbCgSery6hWm9S2+JklS3C6d17KFqdJaN5bBLYxcV+RnbIyShionJWzeh6vbeL8YP49DzDP2zvr9+fr1FiNkpoXni1rmKrWijU+zs1aA+j9i2L1RYsE9qcAO3vYoNbTZstxdslLm0qkfmzDp/IHSDtkBSSUnxKH+RfNKH8vyZoNb0hFrBt2QgdL9F/Xn8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI1PR04MB7182.eurprd04.prod.outlook.com (2603:10a6:800:121::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 11:07:13 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9846.025; Thu, 30 Apr 2026
 11:07:13 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	spacemit@lists.linux.dev,
	UNGLinuxDriver@microchip.com,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Nitin Rawat <quic_nitirawa@quicinc.com>
Subject: [PATCH v7 phy-next 10/27] scsi: ufs: qcom: keep parallel track of PHY power state
Date: Thu, 30 Apr 2026 14:06:35 +0300
Message-Id: <20260430110652.558622-11-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430110652.558622-1-vladimir.oltean@nxp.com>
References: <20260430110652.558622-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0024.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::34) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI1PR04MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d4d7bf2-9684-4269-c833-08dea6a8a213
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|366016|19092799006|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	QFBNNDxNL2i4/11noJFadnrY7LsLwyMzBqgXzJ9Eq6lnZ0zEbUXVLOc5Vm15Vb6wNUIWLG0VJ5cx935VaV/zf9QVP2RRgPCMj26IyDnNibejbEKlnnva0j7II5AcYyzer2QircnNs7QMNQw2oJM6yKFbFaQbZJHjdblgeA7tSJZlcPz6x4SRfzdDXAPzl5C622iVIbyg6rrv675+LYm7jkazioMBQNCuwEXHoRjGWNnBORNp0Ww0swcooyLD/3GLNO++lgMwSDlmotoKJlIS7/NdS0s/SWbf5u/OfMsuJcNVntvKG9PqCJo+qklQbhHDH3Eiuj4aDmhZCtAmHqPX2XZqczWTxpov9kDKKB6AbTvnupzSdxj8EXjKNYwzSKRIuTLiEDCrAWltZdNHjs7EXEN1nScFpKUjWEAVRNKLf8dzKkbCkdlo1NzTplJMqkSA2jajlJexrwvyuO2jmzCe4Ghqk/OQVZcoaQG272w344KX1qXg/LUV65FV2qejgYg5mx/mmuzQAib7Ltdg6Ek5w0KpXz0Ip0IQiv9R+j6sl9/GjJ+Vp7Vx923YcVWdXuhI2AEg2qUmnjlCTNkzbXAJEKJIqhkxNjwLuuG0tExy3qARQrLgFumb8fHxexNPQP1i0mI2hw1Qv6UiDtYUTKWbET355L8tH7TMr8JsNCCBQ+2xEd2bawHrHaJgjkmgELF1+WqqBoDLYWPwkOEGs6giLVlphaE4VJXFojPjj6ZYPL8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(19092799006)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mYFzcQ8xMdG4vKppMvv2VosvUysNjrf4g7gkSn06wDGkUOI/Cbb4pC8mstEs?=
 =?us-ascii?Q?6JDV5MezmBai1MCy4o2Ojve1OIoVcYbWH+QkldiOAfDzQSFib6G0A1q+DIhu?=
 =?us-ascii?Q?HJo1usBl1uyY1cvkVftuZU6RWZcbQLRqF5T2A3qIXzzXQJz0tWumxiW7d2nS?=
 =?us-ascii?Q?jJCLUysA+ItChckphDHDkFQRZ9h1uc+ngWQU6VjumQ0bhwiZO4JwslqmKA6J?=
 =?us-ascii?Q?kTCsBSe8o403QE984+n+BVPkfFG0yLJXsNH4BO9/7HCm1pR7/wXi+44bSOyN?=
 =?us-ascii?Q?jDcwZ7ecYAj58+1bJJVj1RyDlbWFGi5m29d5cBobXYq5bxkqBdXXbLB/Dkjk?=
 =?us-ascii?Q?Yh9ofIPFBtofMB5TzGuA0vcw4ohSf15O+uw1Ruqpr+ZJcS28eL6x6EbkPFeA?=
 =?us-ascii?Q?CD49H1DgTUkdqx7r6/CEDwaMuxOovquWBsH3VvE3G/ck4R/qHvYUrBGcsIRg?=
 =?us-ascii?Q?HSDlnySnCOxMWTSrRGCKEimyAbeh9VLz45qUdik9SNrJ6kYXzRWNpUbJmOup?=
 =?us-ascii?Q?5H8cZ+QcwxUgsRqh+iUHNY8/WxbQFKT/G2QkbZY9GpWcCEb6i0cwd+Xut7Ux?=
 =?us-ascii?Q?/PjWCx3CSYMBz/5VwD9bL5kBVaU2ShGXWFESt3nDQn43FZREkRWOfxqAxnjS?=
 =?us-ascii?Q?lpUeToYbyHiGE45R9kIeZFJEKwWjlSLrVcNlZLm2Bgvnm4dsQ4t6nPKdZUY8?=
 =?us-ascii?Q?wZLIR2qEQSyJArrnOwIaggcEaSsp1olUkD4dl3xgy+HghvX/kbMMHERnp4s2?=
 =?us-ascii?Q?8ihcr3HlocM/YiJoWgRz73mAwmAXgNTEzoshJ0b2d1X1Vb3jO+Q6CYy7LCia?=
 =?us-ascii?Q?0bbRJndNCC0KPY0TYajzBW93QLo+QMp7fQZb0jFIXOV0t+tWJ97S3Byn/Xby?=
 =?us-ascii?Q?ja21R/ML77bYzsWccwPX2VXdYttv4vgmRHyNcs5hIMEmajdbrpHVHPj847Xl?=
 =?us-ascii?Q?jeJNVB1vIIPWLkezpKHUySGBPW3bNqmAYEPVGtW2Q125oV5lH8CotJahOnFP?=
 =?us-ascii?Q?IOhnYhMnoR9Busbb6g2PQQbPAIeWHDrTz+kmZUTX9l5PcmSI1lTHCZVpIuXA?=
 =?us-ascii?Q?gVEFnrjLygdt2KTw//NXmUPkzkKQFEupHxqSZTQDKT3gtGQT0qJy2ZCusOYa?=
 =?us-ascii?Q?4DFcpJJLiWrsFP84xWIxz4RgB26Xqu18gHuXwRIBPh4LoPv7hKKqYwXaS1Fd?=
 =?us-ascii?Q?s6jxBRXlARDztg7TKl1MmkTeEfh/qmOeoQJzInsdjf+v/Sn4JIQd1QP68TcY?=
 =?us-ascii?Q?+0doC2b0GHaGFloK/7vSF9yO+6tUuGzJ+iYcMJ5ulxZgHkG9X4OvKb3yM0wy?=
 =?us-ascii?Q?edX+n+6na75y7Gku2mpll822U9ZJ5yYU5EENZ6CTaOEDd8r0zg0EK4j5aYHQ?=
 =?us-ascii?Q?BNE5ggHa90ug7Ti1luFMzjh7ozIegUey6E/iD5moI7QJNcJIJ7Dqf+v9gQQg?=
 =?us-ascii?Q?UA33Miyu1GGc0TyiE83Bx0yc5xcoAVDG6Q8uZ7rr9U4PtModGERUXVAPKfc7?=
 =?us-ascii?Q?d2MnqqrCJlmtNSWiAaWQGrUxw/Fop/VHT0nF13cFoB6ROqKYggc8iGA6zDps?=
 =?us-ascii?Q?onTfOmBfsu/SHhYQbTjSINQhRoZMrZry0uPX+nBc7bvXePkjXBxmeMeRD/Zm?=
 =?us-ascii?Q?DML24+xCzmw5XaQ7WppEfJs5A+TZWrcoUZG3jCnOvhajw4roDkKfIIrJQKXS?=
 =?us-ascii?Q?K1AegjGOAtZMpzXqOexdgzb4vHhPjWrjXWcQ+h+1JngRSJXGkHZZqiM9rCh9?=
 =?us-ascii?Q?D5kLcC0g4dtxzfuQaOsEOxWfOb60IlRE0ZdTOIj3mDHMKktatTf+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4d7bf2-9684-4269-c833-08dea6a8a213
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:07:13.8663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LOQ0KlGMKhNmbUVKF72A0MPaHLcgZxpJLmelzY8C+vvVypPeI0Bz1/N2wIsOZjF+cOC9GFNDglzlAMukR1xfcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7182
X-Rspamd-Queue-Id: 4C8474A186F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7439-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid,oracle.com:email,hansenpartnership.com:email,quicinc.com:email]

PHY consumer drivers should not look at the phy->power_count (a PHY
internal field), because in the general case there might also be other
consumers who have called phy_power_on() too, so the fact that the
power_count is non-zero does not mean that we did.

Moreover, struct phy will become opaque soon, so the qcom UFS driver
will not be able to apply this pattern anymore.

By all accounts, the need for ufs_qcom_power_up_sequence() to call
phy_power_off() prior to phy_init() denotes a skewed state of affairs.

(1) The Generic PHY API warns if phy_power_on() is called prior to
    phy_init() - which ufs-qcom.c does, from ufs_qcom_setup_clocks().
    The UFS controller driver hides its tracks by dropping the power
    count prior to phy_init(), and that API violation goes undetected.

(2) phy_calibrate(), as implemented by the phy-qcom-qmp-ufs.c provider,
    only works once after power on. Next time it will time out. And
    since ufs_qcom_hce_enable_notify() -> ufs_qcom_power_up_sequence()
    is called in a retry loop by the UFS core, the PHY power would
    normally be on, hence the phy_power_off() call to ensure the
    consistent state during phy_calibrate().

The above constitute improper Generic PHY API use, *but* fixing that
requires delicate surgery and I'm only here to stop this PHY consumer
from using fields it's not supposed to.

Once this discussion is settled, I will also address the above issues as
follow-ups:
https://lore.kernel.org/linux-phy/20260327112858.r5lpqygtvsane2vf@skbuf/

Until then, we can reimplement the logic in this driver in a
bug-compatible way, by keeping parallel track of just the UFS
controller's calls to phy_power_on() and phy_power_off().

Note that phy_power_off() shouldn't return an error in general and
doesn't return an error in the particular case of the phy-qcom-qmp-ufs.c
provider.  So I've removed the one handling of phy_power_off() errors
from ufs_qcom_setup_clocks().

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Nitin Rawat <quic_nitirawa@quicinc.com>

v6->v7: none
v5->v6:
- rewrite commit message
- drop phy_power_off() error handling from ufs_qcom_setup_clocks()
v4->v5: patch is new
---
 drivers/ufs/host/ufs-qcom.c | 15 ++++++++-------
 drivers/ufs/host/ufs-qcom.h |  1 +
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index bc037db46624..872e4effa60f 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -508,9 +508,10 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
 	if (ret)
 		return ret;
 
-	if (phy->power_count)
+	if (host->phy_powered_on) {
 		phy_power_off(phy);
-
+		host->phy_powered_on = false;
+	}
 
 	/* phy initialization - calibrate the phy */
 	ret = phy_init(phy);
@@ -531,6 +532,7 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
 			__func__, ret);
 		goto out_disable_phy;
 	}
+	host->phy_powered_on = true;
 
 	ret = phy_calibrate(phy);
 	if (ret) {
@@ -1447,11 +1449,8 @@ static int ufs_qcom_setup_clocks(struct ufs_hba *hba, bool on,
 				ufs_qcom_dev_ref_clk_ctrl(host, false);
 			}
 
-			err = phy_power_off(phy);
-			if (err) {
-				dev_err(hba->dev, "phy power off failed, ret=%d\n", err);
-				return err;
-			}
+			phy_power_off(phy);
+			host->phy_powered_on = false;
 		}
 		break;
 	case POST_CHANGE:
@@ -1461,6 +1460,7 @@ static int ufs_qcom_setup_clocks(struct ufs_hba *hba, bool on,
 				dev_err(hba->dev, "phy power on failed, ret = %d\n", err);
 				return err;
 			}
+			host->phy_powered_on = true;
 
 			/* enable the device ref clock for HS mode*/
 			if (ufshcd_is_hs_mode(&hba->pwr_info))
@@ -1651,6 +1651,7 @@ static void ufs_qcom_exit(struct ufs_hba *hba)
 
 	ufs_qcom_disable_lane_clks(host);
 	phy_power_off(host->generic_phy);
+	host->phy_powered_on = false;
 	phy_exit(host->generic_phy);
 }
 
diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index 5d083331a7f4..6eafba3c203b 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -322,6 +322,7 @@ struct ufs_qcom_host {
 	struct clk_bulk_data *clks;
 	u32 num_clks;
 	bool is_lane_clks_enabled;
+	bool phy_powered_on;
 
 	struct icc_path *icc_ddr;
 	struct icc_path *icc_cpu;
-- 
2.34.1


