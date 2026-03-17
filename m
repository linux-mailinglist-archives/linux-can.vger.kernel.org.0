Return-Path: <linux-can+bounces-7118-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SUxJJyfguWlhPAIAu9opvQ
	(envelope-from <linux-can+bounces-7118-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 00:13:43 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB802B3F47
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 00:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A96A030A819D
	for <lists+linux-can@lfdr.de>; Tue, 17 Mar 2026 23:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65F0402B87;
	Tue, 17 Mar 2026 23:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OZfLMr7w"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013052.outbound.protection.outlook.com [52.101.72.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899133FE677;
	Tue, 17 Mar 2026 23:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773788767; cv=fail; b=QIxLyUptQfQraK+Fj2SUtGb2qGNDcP7jkFxpDFidXReqNIgPzJbIB5tk/NA+epKdS/kv8GTllt8feXA7GdLj++TkDWK710KKqeaM/ytFEYou6jsv9O5/XzbS5p41IMUWRU6jFiY9/4jWn4GQZzvZgCBtWPaScee1Hx1tcxXVLtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773788767; c=relaxed/simple;
	bh=hTAA3ppDvXtpOzJcfeyN8flRi6erkL0Gx2p1jLWs+PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kl1vsXHfXlltNJsyk7A/QtW8PYolwX1DiIYa9JFLuzSi/R1HLPi9gBdjWkfrj87z5ZVgzHHO+Ea8zMXvSNO15xu/7VO768H3uHLOEV3NPhEEnF8p2BxwKqVBroTrcL3XKGF5lkI8bW6AsuKe3wEyhTAZL/YX4tHDMnobD3PzgwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OZfLMr7w; arc=fail smtp.client-ip=52.101.72.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kK+a2ANSbejFPU+g0TCsdNGjuWJc6a0+9Kw9AkB6jwua48veYDaSYB5/hKBe7CGrS4qtneTN5tOFboVswym54wCvkvZeXsDcRsJaO1B0o7uW6ys8v+vSxiaNKuv7sOR5r895bjxEA89rkZ3qdBmQrIiW8hhHVd0401rLPFoY+UAb7vpwoQceFF0XiuG/J1iE8IOew6k0zlgqttNMenwuuzLp6V91OGnKyUScz+VcL2sxxYUmKAnnT02/2LHlkGvl1f0Sngsk38LGYDM2uVYUV+lRIrUl1lmPskLa7KkP3aYacLZr0AYhXhzhWKyJ7XmWGrvc7vWXxbTi5W2XPdnY/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lK78HZM3PotOplPXquPH+xA8nZR28xFvOayIUO1oYbQ=;
 b=AzkPn+r53aa6S/fXcII1r4OzQmYcczNk40NxrsQUKGVze/1+FULqu4b3MUQO6ugE5RaFuafKKjBNYEnzGKYm+EXkozYG+67q+ardTxYWDzhcrHjprCMm7oSE1Jo6S2oiNYiXXXqY6k+5J2QGZZUeuqCyeCspoG9mXtQ055JnK3U2S3zLYjq9N3Cd2j2yHVe1VpW9wzGdK3RGLNFjl1w1/raCZ7ejTEWSJZj7MGYVciUZTVchjdbnygIuComCLPlNmebHl8MRQZT7CiPoQhWv/nxdBgI2hNBhEeFYayjHcmnXO9HByKTYjk68ng7Hd01q+xdpSD06sYZKBmy3PSO2Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lK78HZM3PotOplPXquPH+xA8nZR28xFvOayIUO1oYbQ=;
 b=OZfLMr7w8fB6rVWowx1Ngp+/XhLDeA5cWRat8ZdgZcl8S56eTen6yzv1NFtQ1ql8SExFN8Rmv/dv09rOS24VO7PZn3ttDI7pdzkc+eUhK/CD17K0Mk5gnxtmY/qBME2m3WzgWMwficZf/N8cpqK5QICScT5D4Y7wzKUsil2XiQUQAZEwQ4Bd30TR2avHKhuLlBfUJnbZMcvv080YsMXkMmYmyeaAtiSdJYUsmayZ87qX1+PVa+S3O6kUFqAXREf0HVoBTERp23GP2nhQC8FWUgaeEhZwODgBE5xlWXV6HUJhwYcDuAyhQ0L4Llp8IAhIzhV8XNR8WjsVNwiN80WbOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DBBPR04MB7643.eurprd04.prod.outlook.com (2603:10a6:10:203::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Tue, 17 Mar
 2026 23:05:45 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 23:05:45 +0000
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
	Chen-Yu Tsai <wens@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Subject: [PATCH v4 phy-next 17/24] media: sunxi: a83-mips-csi2: include PHY provider header
Date: Wed, 18 Mar 2026 01:04:53 +0200
Message-ID: <20260317230500.2056077-18-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317230500.2056077-1-vladimir.oltean@nxp.com>
References: <20260317230500.2056077-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA2P291CA0035.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::11) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DBBPR04MB7643:EE_
X-MS-Office365-Filtering-Correlation-Id: 083e57df-9a9a-4aec-5bae-08de8479b846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|10070799003|1800799024|376014|7416014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	iJ7jr4JERW1cPLh0vb8Wnr5SxJgc7TPOncKn/fh0UZU003fypvyQP5NBMPM005zFu0eq7zUlwAlm9Gm4EZByMpHJwLi0I1GPmi2TbqbiZo3HdsDNrJJHWz6gZIZF+gGjtMoV72F+JcqNiqKs1fKaieG3ZfXxgfZbs48Oe9dVa2iFJIiY8haGN2mb27e8W7J63RffbX7xuVb2jkWjk8xvZknh81kv5BVXlqbR1H3IdP2ix6/dWKB2mLVlkjxnoQBkwm5Zoe21Ft5D64DDWmS7Rf23G8bPFfJNA/Nh0XtEIgiEjqEoA16Dhai3qpy/EOiPOFsO7kqhbJVO7qXuLnnxXze72ObeDE5b32g7cfoPz0aRd8tlYUjIeCW7u2R4bxwBy6iZ1RnDTDzXq/lPY+yRnck3pAgMbYd1V9j8ZfbqHHTrhma9rSSte3uIVAGtuCYMGn9dT2a4YrNDLAdrHYLso+Ja2HActOSfU7q9uws3v19my9E/hKeiTGW7Z2meEmVAsMtgKRIrkecVTW8rBt0BB6v5hyYapSZSzE2hGhzfG1ieQdaBd5W11mdWOtIVVrSxviJ9OmxrKhYWoR1fS1YCduN4pWSIwVV9ExCY5wLd4wHMznJMUOHgxNDf/5AXHVLhpYeFITKY1DIpEALyZYWeonzsjLGkpRAUKaenzKHUENniCtM7A4rT4tnljl3W2Sm80w+Tulj2i2mSnq+4TLMKPqBfacBxY0fbGKIOQLvnaWM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(1800799024)(376014)(7416014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+BqcpilWETYJdsWmWkI9QTbg45chFZpcbFeokGoI3Nbhp6d5bTVLS+3lxVnB?=
 =?us-ascii?Q?yCEgnZtsnUv1KNgaS0wvMLVArtGHwfkCJziPruOJKcck3BlPyTn48RaDI725?=
 =?us-ascii?Q?pHv7xgHe+WVx82QTQiTRZymUu/LSY3hBaZdGiLqjFHDki7ljzA6RT3HGGjmU?=
 =?us-ascii?Q?a+Caq2wjWNah3wrnoucrbH2SirE5+GmK1idBc+HoYVxzzeNeNYUsnTwrY8z3?=
 =?us-ascii?Q?KaGeJ9v8gvSGxaUASxxcXH8CD1XovnKEK3mtDAPNTwz6I9/OW2c4yqYmBQum?=
 =?us-ascii?Q?v3y5C5E3s/3WluJe1nLbLiu+SMp25C0CNAIvidra9rBCq945WD3dN9GuleSo?=
 =?us-ascii?Q?ghn/N9pwOdQPHdL1sjvGqh5jxYX7p1QWkbEq/pL6Z4BDNmxhkro3xSEibw6i?=
 =?us-ascii?Q?oh+SbjaSn6ICxJyFb6FoBvPhcpyZOvdfVvYoqPoV3CVYou/TFiLiR3908q/J?=
 =?us-ascii?Q?5YRXgNyhKEXyMyqSuqdOT+GJPYY7OCVo0iJ38zYHO5LIftwkyqq6Eb40Us08?=
 =?us-ascii?Q?aRA2g341oUxjU3xxbFTA9TpPhd2TGARq6BKP9902wpY8+DssTk7ct9ee1O05?=
 =?us-ascii?Q?OFJo28U2rTCMP3tw0UeEeRTkUOsqNAABKnWlZtjyVelxDqiOhtcL1ilySyOL?=
 =?us-ascii?Q?yq77vJeq9TGjLID6NuviFnnXdjWmODvbpLTQRIfwb9eBg80vKnfF7k1zkqzw?=
 =?us-ascii?Q?aJ0KtSIL1naBizrbGLfMb3r2MYI7MqOgu9ECLXiL6Nsap0kwg/TEHuH7Fpvl?=
 =?us-ascii?Q?z3r4yZ9HiDev47iV/L4hVTt9dllZ1ecgzxNL6tatczy5Kclqi8xW/HvdNELo?=
 =?us-ascii?Q?WrKOXCpTUpSMnCIe0OH1VWvftIgsmXQXaj+V0130XmZC45mHQ5mvTVIe0IeC?=
 =?us-ascii?Q?LUDNIaFRj0/5PSGkS7QEKcguf++2q24nYnWgNMxhSUyhnbsHmuJ6TOoQ8VxB?=
 =?us-ascii?Q?gwbBfDZo4Y6mfqlN4TE6XA1HipijUtyQqiIkElfdnVXM76KgFHuCeHVZ64hl?=
 =?us-ascii?Q?cKRpuPvK1OEc52KOZPgEZo0RpEiwkDMT6ob8q+moI6W5lLxmhgHNPC1QKRPn?=
 =?us-ascii?Q?XmnQxRuMEr5AfMxGPG8hrda6Y8GI2ni+x88hc9Fj9ItenSUuEoFJjpk7TmDg?=
 =?us-ascii?Q?cOCIp9tcLnSa40N8vFfc8Qyok0LdQMJISX7SRzRtuRrL4XujXJ2C3t5I7NnD?=
 =?us-ascii?Q?B6Le0EX/7oD3iDsniDF0O7JeqOuFYOhCkK9GvtaK+R7oI2V84NfpzLnKr72Y?=
 =?us-ascii?Q?E+fpyduif2kH8MbIq7jLyzgBI+PBmPq+oafVnNy2UGKaKRiwX4qxQ+5G0YhJ?=
 =?us-ascii?Q?gMHEWRIBeKRgoVEiSN3CrJo1budaUJjmmdAa0+57csXusLHC4frBDetD3L74?=
 =?us-ascii?Q?t0hOnsFhtWuhOb7WFpIe1T+dsl/As9u0WE2bClVQfxdJ4ytDJiot5Zf7ij2D?=
 =?us-ascii?Q?sqB6+N49A7bdoS/PP4eXbilBpLddTt9/evLTz0rE17aVqhVL4YzoerIJdUoP?=
 =?us-ascii?Q?l2XMnu2ajOv2X71z5foeJKN4BZjUkWdH9g3YxGc44k2ZvnB2J+BO8QCML3/V?=
 =?us-ascii?Q?J9GsqfGuIZtGtQxjKl9u7Jg/8MPg4FucztJo/PVtDLBeusHJ+WU0hjLtDiYl?=
 =?us-ascii?Q?C1vQYDz44sLHoieHE7Z2tL37gfb+Rtlw5JZRF8hJGpiQDtNs4lD0+dK9zQBz?=
 =?us-ascii?Q?1zUkfNhbdxCifcRqReNAMxCGycBvCuO3pSzVSMAVUPMsmXNvxylyOpcIWo6e?=
 =?us-ascii?Q?qI/S1VDRG4gN7G3oWPzEXnqctUXyCaINP62NA7VXD+uBIfcqV5qagIWGLTK8?=
X-MS-Exchange-AntiSpam-MessageData-1: ujzpCju9rE/XjfHE1JiZOrJ8IjViVXY09OY=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 083e57df-9a9a-4aec-5bae-08de8479b846
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 23:05:45.1815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nV2C5VTLC1AMLVOrKhEaZm18yP3SX0/J0UTFHtCUFtxhi6CcR+8o1fgvVEIAlATTiIk7VaHnLAV0AKwutuBy7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7643
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,gmail.com,sholland.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7118-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sholland.org:email,bootlin.com:email]
X-Rspamd-Queue-Id: 1EB802B3F47
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The introduction commit 576d196c522b ("media: sunxi: Add support for the
A83T MIPI CSI-2 controller") says:

    This implementation splits the protocol and D-PHY registers and
    uses the PHY framework internally. The D-PHY is not registered as a
    standalone PHY driver since it cannot be used with any other
    controller.

However, this does not matter, and is not the only instance of tight PHY
provider <-> consumer pairing. According to Vinod Koul, having PHY
provider drivers outside of drivers/phy/ is discouraged, although it
would be difficult for me to address a proper movement here.

So just include the private provider API header from drivers/phy/ and
leave a FIXME in place.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Acked-by: Chen-Yu Tsai <wens@kernel.org>
---
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Chen-Yu Tsai <wens@kernel.org>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Samuel Holland <samuel@sholland.org>

v3->v4: collect tag
v1->v3: none
---
 .../media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_dphy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_dphy.c b/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_dphy.c
index 24bbcc85013d..1143feeb4fcb 100644
--- a/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_dphy.c
+++ b/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_dphy.c
@@ -4,9 +4,9 @@
  * Author: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
  */
 
-#include <linux/phy/phy.h>
 #include <linux/regmap.h>
 
+#include "../../../../phy/phy-provider.h" /* FIXME */
 #include "sun8i_a83t_dphy.h"
 #include "sun8i_a83t_mipi_csi2.h"
 
-- 
2.43.0


