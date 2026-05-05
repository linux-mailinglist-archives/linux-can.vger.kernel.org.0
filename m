Return-Path: <linux-can+bounces-7486-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SK6YIC+5+WmNBAMAu9opvQ
	(envelope-from <linux-can+bounces-7486-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 11:32:31 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 380664C9C85
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 11:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D8FE7303F44E
	for <lists+linux-can@lfdr.de>; Tue,  5 May 2026 09:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E763320CCC;
	Tue,  5 May 2026 09:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="e7Pv1Xcx"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013049.outbound.protection.outlook.com [52.101.72.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BD32D1F64;
	Tue,  5 May 2026 09:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777973449; cv=fail; b=obXBzLKWvz5f5i5R7ofEDircQ8eRCCdT5B3ryajKuKkL6TINEIRSJ3+4jNMIhdO1yU6Qs7X7QU8SKnCeguFoyd/DIO2gq0aIgmN+X7FOVr3N8R3WbiL9glAlwkftw/mNyiGYKQtXmzQWQQWhVbZ1fFSVv1ecnbdABEieqO75+jQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777973449; c=relaxed/simple;
	bh=aUMt/AoKK8JXcrMD0dth9hfWr0ap+6j3M4kHYsP8HMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gOcmny79PXLv8/kIIIZ+P9ornNAw8/E8tE0eBH6shsa/o+HLAwhaqg+5M6awFa7TWbYwvm2DLmrPZcPYIN3agE8bVCmlX4FaRI66epcZTA6P1NdQUIezh3o5jEOkxdLHXUQIc7NWn+BHwuldW8TnFfgZmPv3J9cV9aXr2KtNDYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=e7Pv1Xcx; arc=fail smtp.client-ip=52.101.72.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aU9zGRIR3Yqssvlv6dvxzFhnHC4HYZKYn2eawG/0vIOxr6Wc5y4yXwi+1GgZocRlyHaWcuphwUGz+VCdgg1bn0zmW97zWtDrpdoqN9AEo+VJumkt6HQHSEi9D4P/fgOlBCaygjO0/Kv+5sP8KbgiiVrHCpnMPMQ6E4I/GNKsafQpAT1ga150AZtXhytA5IdxtHu34KQyc/BFJraTkkG/eYDtoWcgUxNNkKOq0n1Yzs3/Zip/eHcLZePnAAtzLpnUahPTeVsmCgm05CTRByWffq9svsmUnHaJPkTg6r02sKtRzrt7ModejrMcdlU6rD56IAaCMjBaz04J2Q05C2PJbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=buMu2dCWSqT2zwkuvzvOyaoMh5IAF1ls0sy2X5mRtfM=;
 b=wXyJViAG1QQ4ySMYZpCn7xm5hwTvoR5PkUhdohDjHqn0CAtWIaNd5650RTqbjJwZggiEZj1FSHbIALR0E6JC9IBtmnnKRSc8FXY8qITw7fKUSEy8jrIJ7Y5Tr8QXQcFTcB1FSjgNIYKnVc9ZMsjQf3bPijDchy+D2lveAUJe1LRZzjnvoOSz5zfqktg4tUxb+VFYbqBLM/O30nzRVxnvGZ6faD+Fy0XSKRHkTvpfIaGpPBn+XEEpKJog93Tih2VNHudKWWG85YT6tPQwtCwkN6pnVYyv8H6E9wfLS1d3ytohnTpU5awMTVvOruuZC3qpN1Knc2QFCThntSz7dl1yuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buMu2dCWSqT2zwkuvzvOyaoMh5IAF1ls0sy2X5mRtfM=;
 b=e7Pv1Xcx8u3eW3ACjTXISArGZN9QSv62Oo5Rm7qzQ+ZXi4Kbag3X7+yksoIAQgfyRGHX7tpWvv29FA0amvAePzsDDt1knvr3db/cF88ZmVMi8duj75U0H4jOSm+hMv051jnn26npr+kDW0SDtULrGN7l38dNSw7+O07wfz1boDfGek6eabdbzV/wRlyrcmgP1ebIiqgfgUOkb+/KJLbfY6Zg27WW8ecxOmPTs3kJRg2V7C6p8wBSaA/hfvKY0LTVbupNm8AiGWUERmN/eb1sX/uRejTdjZ0rmlJVjvYlDp4CbbWHW/uOfzs5+yqKYxF5kRU+lblPzqzfDjSxc1VHAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GV4PR04MB11305.eurprd04.prod.outlook.com (2603:10a6:150:297::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 09:30:39 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 09:30:39 +0000
Date: Tue, 5 May 2026 12:30:31 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-can@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	spacemit@lists.linux.dev, UNGLinuxDriver@microchip.com,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	=?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Chanho Park <chanho61.park@samsung.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Damien Le Moal <dlemoal@kernel.org>,
	Daniel Machon <daniel.machon@microchip.com>,
	David Airlie <airlied@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
	Inki Dae <inki.dae@samsung.com>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	JC Kuo <jckuo@nvidia.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Joe Perches <joe@perches.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kevin Xie <kevin.xie@starfivetech.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Linus Walleij <linusw@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Michael Dege <michael.dege@renesas.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Niklas Cassel <cassel@kernel.org>,
	Nitin Rawat <quic_nitirawa@quicinc.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Peter Chen <peter.chen@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Robert Foss <rfoss@kernel.org>, Rob Herring <robh@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Samuel Holland <samuel@sholland.org>,
	Sandy Huang <hjc@rock-chips.com>,
	Sascha Hauer <s.hauer@pengutronix.de>, Sean Paul <sean@poorly.run>,
	Sebastian Reichel <sre@kernel.org>,
	Shawn Guo <shawn.guo@linaro.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Simona Vetter <simona@ffwll.ch>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Vincent Mailhol <mailhol@kernel.org>, Yixun Lan <dlan@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH v7 phy-next 15/27] phy: move provider API out of public
 <linux/phy/phy.h>
Message-ID: <20260505093031.zjewnvpvyiptxz6f@skbuf>
References: <20260430110652.558622-1-vladimir.oltean@nxp.com>
 <20260430110652.558622-16-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430110652.558622-16-vladimir.oltean@nxp.com>
X-ClientProxiedBy: VI1PR08CA0215.eurprd08.prod.outlook.com
 (2603:10a6:802:15::24) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GV4PR04MB11305:EE_
X-MS-Office365-Filtering-Correlation-Id: d4591da2-10e3-4859-6d51-08deaa88f835
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|376014|10070799003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 6xY0Nr6S4qKu7jd+eHgx4rLlps2tc/iWiqVGcbHplpY9OF/Syt5PMpxldumR8pWkUgIlu2LY42tftrQHrYNdcuLkT22HhsVYO28fVo0nhi7heDN4LBqsMRrexw2YGUda2TqhQ9dQHBO9jvBmJW+h6zTodbRuo6UL1R0TLpq+D8JaqrkHiS3MSxLuGIGffkSvWfXKiRaDu4hDkWFlJqUA6PB+UIz5hlIk9Sxo89inihM0nWLWxD2EMmyKrxrEhw2bZ6THcjjKkKkQApXLCZfXBqMTXNxh7PK/rPuY/JtBL+HCpJYF2B/DJ+UEIQN4Z+QdpjfWv7WotyoSlUT4gQyfnb07XXeJ8K/BmnTR1r2gJB12YLX3R2dYnNounD5hY4X2MdwF5PdavVghzwzFtl+h8IkMHFUZ59gjFe6XW4PeaXwivvj3TCd+/QyjrFiHV5RFialOWVEd35VmmS02DWjFfM1ww4IV0F86gmWv43lnMTqEq5XXdi23+Q8eO9HHz7N3P1JX0EGzIwDz0jukpVOKHvyF9MB8LAq9494xMC7cUYAfNRas/NPH+wzFki7nPgdcZzZLsqak3d5EVZVVVnMWtm3BbLgQmcfHbuUzPW4oLbnp+Tr0MaZ+4fTjLhGn8Ed/zqbQvec74Lw3hXQ+S7NLfUEEbkyB5fcCXzs9xI7GCnsvIxP+Yr7vm5qq0e6pKzoJ
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(376014)(10070799003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?PyL9NOA2fBkuYBkBFWRmfBNNoJJ6oZOHiG6678lJXvmieFUx4dppjBn7tV6v?=
 =?us-ascii?Q?1sx9YSUJCypa8XZNiwAA3piz1/wG/g5/xU52Nl4zZ+76gNxLSvadY/ciBQT3?=
 =?us-ascii?Q?jqudsYlFaCWbrFO5UFEt1hN1zivnNfmtpD6z/FmmOcskhsMwOH3EE+w0ucNT?=
 =?us-ascii?Q?G+aQmSLibMXtsvvmJwyHYaxSwhysEk+9XhK5hxmAIzEdZwMtl3I/20G7C7wl?=
 =?us-ascii?Q?3sgknUfNVkOrWsZvhvUMUucgWWyVhvIHLsn1qkQx03KlF3LktKxATf5X8tiU?=
 =?us-ascii?Q?C4cnSmBAF+xzqzViwy7qyW+FOx1q7yt+AC7pv0mRUnsUvD4UR3BYtIqSLqek?=
 =?us-ascii?Q?8l4TgFKJicbs6vNJQ/X5GZativC9OLMZm8MRglciu0EQcPlkd95hSu/OpH3b?=
 =?us-ascii?Q?wt0FYjbb+TEzIoejX0jxy9JKXDqRbqF3oNH+iu+igJl0m44HZTXNYW3bPd0C?=
 =?us-ascii?Q?xFO3+Fm/xWdDu0aXdQNJ7IlNUgnflzJBZZAgCBUzyy0uQdlyS5Qde0gXjm6G?=
 =?us-ascii?Q?LJ0pazb8Ct1ZEtxi1xrFHzTHhU4HrOFSjX4qDYQNP7ymMEAvmlwZeAldSBo3?=
 =?us-ascii?Q?0ccmICVcD4AY3Hl4N64Z4JJrsFRlv1VPMKZfI3JmPJ6mwr9bggDrL8M3Met1?=
 =?us-ascii?Q?EdUlp7gbl7ksPEYBljmxea0d74hOsFtY6dD1HXSR/Da/n+ehNS1NvjNHQFNQ?=
 =?us-ascii?Q?awuIG11KazVXaOupWT47T0DvukY17s+ju6QmFvFSUXvL7dj7gscb96kz0U3U?=
 =?us-ascii?Q?S7cTxks87nxFVvbrAPWXyGD3tEhDqV/PxDbTIILHDJnxwuk8uAdaw2m2FbYD?=
 =?us-ascii?Q?q1XIoUylGy/b7Y0jqBB4T6WuIUDv51yvLVk/Mtk5qE72OLcQ6azfBI1ER51D?=
 =?us-ascii?Q?os348whgQSS0wJ4PGURnd5vLaVI5IA06PQ54zG0yKheYiATA714i5Nv1bguI?=
 =?us-ascii?Q?GtwLK3pX67P5JYs/8xmn0nx/yPYk+29UdiEP21Ax1MkCNM7CEbBwJtpYmdFJ?=
 =?us-ascii?Q?XlEJbIKE+JXWIWSYMBNMcGeLqOzTUK0Db2POZPm8CRVd0CxFgyw0cKB4/2VS?=
 =?us-ascii?Q?X7j+1pcThGtdXmgpf3+Ny9MJcelGO5nFDG5XRNCVvYqlzU71ZgFEceIaR/nH?=
 =?us-ascii?Q?2dnrjKBxv8wYfZ4PcsDW3r1U/Hba5kelx31LA+X8BfWW7ttl7Y4OFHc/fQ5Z?=
 =?us-ascii?Q?nrRgmShubwbZE7R7bMuDNH5b1WKyriQi2ixvlnbXl91jhyVv+kTqVcbH+Y0C?=
 =?us-ascii?Q?HXN6qqAR5079yyR6Yr+jcfG2um3gs6zHuyC1RHKRZHrgRoHXZYBvNFTuvB6O?=
 =?us-ascii?Q?t21qzM10EcjuHLnsMkqi2yPXzmNR8E69p49UwO6TYIC6Sai62J5QkkslAEvn?=
 =?us-ascii?Q?yULaRGIU1plNc1VPYnmIzJD5hLs8IZEP8F9o+Kwf+BUvH3Lc0Yw3xMKjkHiz?=
 =?us-ascii?Q?5oAl5rnz0IgIoLvT61ZPix2Fzx/dIT637mB/LHYnG5bOrJd/2vtFE0tT38yv?=
 =?us-ascii?Q?PMtA2nobz27pg8IZu/+epdUNs7JAT0ATix0EHU102rw48x+z3FjiXY4H4F37?=
 =?us-ascii?Q?yZAZCIFEQq+YPFiXMMGHZN0Gkr/lBRD50rrpu4fKF5ETovlyElrHYAKB+X0Z?=
 =?us-ascii?Q?1VAjoWbjbBUT+a/xc/2mthYRWTMIMWJ+ELyQjk12PWpiOHxli2Jq28+/aOY2?=
 =?us-ascii?Q?svTzPYvkLy97MFz2mTu729oUjziVN3nqmX8g6WrAxL2E5BVxX1xjaiWgU7UM?=
 =?us-ascii?Q?lR/rHmz9zntS5FrAQaeELrgMQMR9RIjaBzvGoWkiQsQGJYUlvxQx32+CIUnj?=
X-MS-Exchange-AntiSpam-MessageData-1: hxYglHDTIzGfqSbgtIeQxF1qnkmjxvCb/wg=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4591da2-10e3-4859-6d51-08deaa88f835
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 09:30:39.5222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UpodD0h0Y+qFHJFnV+zFvLz3JOETD18Xns2JkYQZ7/rjZzqjbRG1wBsGSizQedJx0xrLgIQy0xm9cxcB+fItbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11305
X-Rspamd-Queue-Id: 380664C9C85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,oss.qualcomm.com,linux.dev,bootlin.com,lunn.ch,intel.com,rock-chips.com,google.com,samsung.com,tuxon.dev,gmail.com,davemloft.net,nxp.com,glider.be,linuxfoundation.org,sntech.de,amarulasolutions.com,HansenPartnership.com,nvidia.com,perches.com,kwiboo.se,starfivetech.com,ideasonboard.com,linux.intel.com,pengutronix.de,somainline.org,baylibre.com,oracle.com,renesas.com,quicinc.com,redhat.com,armlinux.org.uk,sholland.org,poorly.run,ffwll.ch,synopsys.com,suse.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7486-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCPT_COUNT_GT_50(0.00)[102];
	TAGGED_RCPT(0.00)[linux-can,netdev,renesas,linaro,kernel];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email]

Sashiko says:
> commit 65f3c7aba94024fd51e12abfeeb5cdaae7e123cd
> Author: Vladimir Oltean <vladimir.oltean@nxp.com>
> phy: move provider API out of public <linux/phy/phy.h>
> 
> The major goal is to hide the contents of struct phy from consumer
> drivers by moving the provider API out of the public linux/phy/phy.h
> header and into drivers/phy/phy-provider.h. For temporary compatibility,
> the consumer header currently includes the provider header via a relative
> path.
> 
> > diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> > index 21aaf2f76e53e..a1aff00fba7c5 100644
> > --- a/drivers/phy/phy-core.c
> > +++ b/drivers/phy/phy-core.c
> [ ... ]
> > @@ -606,6 +622,24 @@ int phy_validate(struct phy *phy, enum phy_mode mode, int submode,
> >  }
> >  EXPORT_SYMBOL_GPL(phy_validate);
> >
> > +enum phy_mode phy_get_mode(struct phy *phy)
> > +{
> > +	return phy->attrs.mode;
> 
> The PHY framework supports optional PHYs (represented as NULL pointers via
> devm_phy_optional_get()). Does this unconditional dereference cause a NULL
> pointer dereference if called with an optional PHY?
> 
> I noticed this was also the case in the previous inline implementation, and
> that a fix is provided later in the series in the commit "phy: make
> phy_get_mode(), phy_(get|set)_bus_width() NULL tolerant".
> 
> > +}
> > +EXPORT_SYMBOL_GPL(phy_get_mode);
> > +
> > +int phy_get_bus_width(struct phy *phy)
> > +{
> > +	return phy->attrs.bus_width;
> 
> Can this also cause a NULL pointer dereference when called with an optional
> PHY?
> 
> > +}
> > +EXPORT_SYMBOL_GPL(phy_get_bus_width);
> > +
> > +void phy_set_bus_width(struct phy *phy, int bus_width)
> > +{
> > +	phy->attrs.bus_width = bus_width;
> 
> Can this also cause a NULL pointer dereference when called with an optional
> PHY?

It was a conscious decision to move code first and then to start fixing
it up later, so that more context is present in 'git blame'. So I will
ignore these comments for issues that are resolved later in the series.

> > +}
> > +EXPORT_SYMBOL_GPL(phy_set_bus_width);
> [ ... ]
> > diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> > index ea47975e288ae..f208edd25afee 100644
> > --- a/include/linux/phy/phy.h
> > +++ b/include/linux/phy/phy.h
> > @@ -1,246 +1,38 @@
> >  /* SPDX-License-Identifier: GPL-2.0-or-later */
> >  /*
> > - * phy.h -- generic phy header file
> > + * phy.h -- Generic PHY consumer API
> [ ... ]
> > -#include <linux/phy/phy-mipi-dphy.h>
> > +#include <linux/phy/phy-props.h>
> >
> > +#include "../../../drivers/phy/phy-provider.h"
> 
> Does this relative include of a private driver header break out-of-tree
> module builds?
> 
> Out-of-tree modules compile against kernel headers packages that typically do
> not contain the private drivers/ directory tree, which would cause
> compilation to fail with a missing file error.
> 
> I note this is resolved later in the series in the commit "phy: remove
> temporary provider compatibility from consumer header".

Yes, out of tree building will temporarily be broken but resolved by the
end of the series for PHY consumers (but remains broken for PHY providers).
My understanding is that support for out of tree modules is best effort,
and I don't see how breakage could be avoided, given Vinod's request to
have phy-provider.h be a non-public header.

