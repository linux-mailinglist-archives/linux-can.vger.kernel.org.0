Return-Path: <linux-can+bounces-7489-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBN3AWPC+WmxDQMAu9opvQ
	(envelope-from <linux-can+bounces-7489-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:11:47 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5E34CAA0A
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3656308A684
	for <lists+linux-can@lfdr.de>; Tue,  5 May 2026 10:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F02C3368B7;
	Tue,  5 May 2026 10:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UOrJ7xzL"
X-Original-To: linux-can@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013059.outbound.protection.outlook.com [52.101.83.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46259335568;
	Tue,  5 May 2026 10:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777975539; cv=fail; b=UcVkvkw2jL763ZLN0TDNwyA6+uAxjvj5uNyb68/odIGxX2jPQls1nk4Ybg5nruQsxk5RKROaCQnEj9IHpco8E8hpW4w/SJfj00NJr6JXU1Kn1j9zu3v/bTLVHKoxpIwC1GWWZ8j0F4RRH0VqgFkubwMCAFwnAQX+sCgNa+y97rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777975539; c=relaxed/simple;
	bh=gCGhQcY+27X5RyL8NyfWSURRvBN5YsrPbPgyFLZ3I8M=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=jlgcsORjXIcg/m5/uGg0r7rWGIBs1xzaAYVL6mqgY5gqklOOPl8gHlxGXsZkOm2lWhiJOoSSaI8qowQTF1dpzleR2T4cHgl6T8Jsp3PvjnE7WDaDg8jXa59FOKkyjNYi9K3/rdW+/QuNju5X7wrqvpxeKd04AJO4VB4/sWnOzM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UOrJ7xzL; arc=fail smtp.client-ip=52.101.83.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QULTuqvPKQEnrFoJSEm4LtcAR0FtkIEJOR79qhJAm1hh3IClZSGAXTFBWzIrnkTfuD/NVNap+wLyJK/0vVLq4CnhWFtheT9eXIMXB2gE9FzsEZ3SDk5wOjetXsVDbiWk8jjNiOmzM/kOv0K9UmuQP4ea2GbiyODYHgNNu4CAvxRkCseKuflpxZ66KRS81j2BSHG6eRVBAWeOK3KeMwuPvC5OUk4tOuedhvV+L9Hd1MN5d8RPFojHKv1n0hbn90QpkWzsclGb8SappGWl6YjSl+o5iKxWtHPcT4F8GxuavIpznRY2rF0cSFIDdrNiHiX+NNS4J6xn4MzLHbAF2Fm8Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d893QG0Njme1QDWNiAIqPe0Lfdna6yNYpSSz0386f3g=;
 b=gkFSuuf6EVvi3fdR1NjuUAFT6ILQCR+SunyIRl2LU6NdqRKqHYcxsdxxPEFp/4fqyOYYG4GRfnUXxbssJablfoLS645JNseOmFFxgobfHWmmoEG8juLOkbKqNsq9Dx3A/sv4Z6rU6o8iYr/Z6xATgTnoqEUNvde63AVKdwKkY0daiN/sFj26IYp+PZ9Vh/s1J9+g4jZzYzKXNZJTAZ424XvJx969dEWsILH+Gy6DQaN242OFcD8VHibmLarK8Vm/s+YumjDmH9SH9Q6Rt/drvZVF1+izNSaBflzETnQqetagXSI7vMRZF706J1M/4R9x3a8cVOCXQ5yOZ3FsMTE/qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d893QG0Njme1QDWNiAIqPe0Lfdna6yNYpSSz0386f3g=;
 b=UOrJ7xzLnAtQ3PXouikVS2/6ao/ArYBL1dEHxZ0busMVz7/RIQFrdeQ1n4PaERxjO/8lk2xT32U+YqLWKCM1x6SvHgWBjY5/ztjr4gA8Y/yPcSN0W4453Q0uja4ReVz1DGWEMyegchZrKWUfrWFFKKWYSsOX7/os8hLySZBYYqgYxDWsBrNw/SIBC0XrpQ9VWe12QlK6x+K5pyHwNB5S+is4ed0eSash4m7CovIvGwxtMfy8aMTx4QsrPSAVr3bzr2t+pwY8Qz9CyZl4urPxu8maPVpvUdQxNUapc6vBVI3TcFbOt4kl5Xe3RGLGdFzq2Q17MMYL7auL+U2UyQ1EFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PA1PR04MB11083.eurprd04.prod.outlook.com (2603:10a6:102:484::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 10:05:30 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 10:05:30 +0000
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
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Can Guo <quic_cang@quicinc.com>,
	Chanho Park <chanho61.park@samsung.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Damien Le Moal <dlemoal@kernel.org>,
	Daniel Machon <daniel.machon@microchip.com>,
	David Airlie <airlied@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
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
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
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
	Robert Foss <rfoss@kernel.org>,
	Rob Herring <robh@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Samuel Holland <samuel@sholland.org>,
	Sandy Huang <hjc@rock-chips.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sean Paul <sean@poorly.run>,
	Sebastian Reichel <sre@kernel.org>,
	Shawn Guo <shawn.guo@linaro.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Simona Vetter <simona@ffwll.ch>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Vincent Mailhol <mailhol@kernel.org>,
	Xu Yang <xu.yang_2@nxp.com>,
	Yixun Lan <dlan@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v8 phy-next 00/31] Split Generic PHY consumer and provider API
Date: Tue,  5 May 2026 13:04:52 +0300
Message-Id: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P189CA0053.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::17) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PA1PR04MB11083:EE_
X-MS-Office365-Filtering-Correlation-Id: 32d10a31-6c1c-4dea-8324-08deaa8dd656
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|1800799024|19092799006|366016|7416014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
 qqyk4WYl69RifxbCVyOYl8tusN6jsgnsDCA0/2YMk7PO5hlhSi4a8GXfaCHVZ6Dc7Fj+iY+jtQrpwCR/pTxZ1i/TKyJ+iAsPpGV1jdlLNcBotXd8HqapvthjbS7QrNO71yNvvOufgAhh+tGjJFfys0IsBcne51BOJ3CZz7hi+PFkChqLo30HJFxrD/VHMXa+VJYwm6//5UxWH+yliilOj3w+AEfUKnUqDn2vtoWEf3HQhh/t7eq7jU0RdigF1b+BXonvpyav+Qx8yZhr2DM9VGNH06Y1sycgVfL8NeOPLy1tGckcUyD5CQNdLLgU9vAi6zQdVE3+zFai7XLmap4NKUzYbVbbxlJg60dd4YKZqG505uQvtPR0hTg+mJZML/2sL0qi6wkeCv1S1BVGQ5Pe6RjEDCFTsHoNXskN/OSvWsfHb5QmJaQocDxpgThwG70qROBu2bt4Wf4iSSHckn9iNkFfIGdU67YeNXnNa3MGTCDHYWLr2dgNoL4pkTgX8TkhE5C4AsdlAfUe7tcXdG8jH3+WRp9RnsZhlU0qOsTTa0X2yi4PIT4BEEh+OPEsAwD+GtaIBQBZEwXm52V9tCOAnIArCmWFZwrwZyVOYczWvxPfabk+uBvec8QMxwEBq3CpCmY0ElFFyeERtkS6yzNUUMJoNFnZU6mz6z648SehqJQ+fdZUXZr7k17rpUCzj+yn7J5jLlgUNrIzwSH4W7OYKA==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(366016)(7416014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VUdQN05nQWlybDYwY0RmUHMzWUoxVzRqb2ZlRVFQTjhjaEdqakVjWVluVHFV?=
 =?utf-8?B?am1BaHZJN053MFFyajA4TUJrSTN4elVuZjhzTjQyZHZQRXVqMG51Zm5yMzJG?=
 =?utf-8?B?bmRMOFQ2OXRTM2Vncnc1QzlBN05XVndhUXdTRDZiTzRPcjhUSk9OL1pidlpT?=
 =?utf-8?B?Z3F4YXFEaFpMU3MveHhqUTI4c2hsbXlvUlFCcW05REI5ZEpobmF2UDZBSklT?=
 =?utf-8?B?cllsaVYvUUNEMjZKUGJtRjlJU0N2L1pjcTVEMm9NNmt1MVhrOVZIUWdGSkxK?=
 =?utf-8?B?VUFtYWh5VDYyaDA0OUVQQ2p6bjZtdUN0bXRuQU1WVVB3dlhKNXNNblZicy9h?=
 =?utf-8?B?MCtiazVQQ2hrMFVtYzVaTEtVS05yQVRyOUpuQzlTblk3bGFKSzdLS2FCbldB?=
 =?utf-8?B?dFV4YnB2MGdZRko5YktOa243OEU5OWE1b2FYbmVSWWlvclY1Q3dPV1hhSlIv?=
 =?utf-8?B?TDNhTVRFZVBLcFNNOGZUNWlLRzhVdEMybGV2THk2UDFoaFNDMXpIVEluVkZG?=
 =?utf-8?B?UnhMZkNwSnIzaWNPSnpiaE5KSkVVZC9JRXdsUVZ6cUlhVnI3d0p1eFRnZlBq?=
 =?utf-8?B?VStoNWc2clFSLzFPVFdaY3p2Nm94VVB3N2FOSmM1UVJvSThZeWpBUFRiNVZX?=
 =?utf-8?B?M3Y0OEY1K3RsM0hpQThjLzZNWWZpK3BPWUpCYnloR1RUNUN5cVd6eFlneFpP?=
 =?utf-8?B?LzdvMCtRTzYyRVR3bVlIa3A1UnUxalJlUGxGYnppZzdlUFh6Nkt5Nmw1QUpo?=
 =?utf-8?B?NmhkZ3pQVEw4Mk5kMDIxM3N6VnZiV1J0UXI0dUQ2Mks3ODM1dDJDNEl1bGgr?=
 =?utf-8?B?bnZGWUo4US91aGxGV1VTczlwQ1ZDZzNDa0dzZDZTYU1Kb3gvOVpwWGNOcGxv?=
 =?utf-8?B?SzVyUmo5U29Dbk95cm5TaElKV3dicWtBT0s5QU8wa0o1NktnU1NDYWNUVFI5?=
 =?utf-8?B?eDltRHRDNUdzdUZKYlloc0R4RUlnczV1NE9CdzVjcXRxczNMOWJwSEwvRnhK?=
 =?utf-8?B?dDN2M2lHR1NpdVk0UC9UV0NvQkJMTjFYMEhLcEhNa0tqakJxVEpDUlQ2Tjg3?=
 =?utf-8?B?QW56a1E4NTQ3MnFpWlZrSXVQYW1rWXl5cUQ5RE9TTDlkWmhtVTNaRzZDYVNL?=
 =?utf-8?B?eTJwK3N4SVlyTUsvODhmbW9oMDhtRXhkdWhDMjdvbEc3MEl6SFFBR2RmNURp?=
 =?utf-8?B?bGlyVzdjK0o3Qm40VktvTy95cjdQc3BxR2l0L2ZwalNvTnFtNy9ZUkYwRUlO?=
 =?utf-8?B?SVU3b3J5cll2RHB5bUplS2ZUekFiZDlONVc3QU4zeE1oeEFObWhpY1hXVERU?=
 =?utf-8?B?SlFkYzJBb3p6elVQRjFDNDB2QU9FNWJNR1lrYlpuY1JxRFN1VXd4K0RFOW5q?=
 =?utf-8?B?Y1pSSEthb2V3djZuRXk1cnd0OFlhVlNYNEtGRVJ5SVJOZEFUNDZoMUV0UUdx?=
 =?utf-8?B?dWRrQ3dDQ0pDci9vSXhBWkRmZjhISExEZG93K3Y3bnYwMTNUT0hidHJjQ25y?=
 =?utf-8?B?U2wxdG1Fb28yVmpNc3ZXTmlsRDF4WUhDVlh0ZFhMUlhNNWFzNi9QZGM0OTJD?=
 =?utf-8?B?UGlsdVlPdmd5THVhM1p2d2xJY24wNURISUJERHlFNHMwWWxjdnpMOUhXSHlZ?=
 =?utf-8?B?Q2tPZkk5MUh1Uzl1NGp1ZktKaDhWYlJXNkozd3RqUEdxVHk0RUVGc0MxRVMy?=
 =?utf-8?B?bFdrdkZkZ3lOaDJyMHlLWWpOU1VkRVZrczZKdFVkL1V6VUswbGlraWx1d0dh?=
 =?utf-8?B?TVU5ZnNmN3JQcjR6c09TNlAydCswYVNPVWFOKzVJbWZVYTg1NytWZnV0bDY3?=
 =?utf-8?B?bm5uQ016V0xlYWZyYi9pRHcvS2JzSzdSVnZ6a3VxRDBmSzJnMGFtQ1ZQZ05O?=
 =?utf-8?B?UzRDY2FMbWtyS0ZpYm5SRzIrQzhZdEpiSktvcllGR096d0pYdXBRRXJCQ0pP?=
 =?utf-8?B?Qkk5bDYvenprL0FDMzNPWmV3cVhBak5vRXl2eHJJckV2Y3d4RjdnN21Uc2ZR?=
 =?utf-8?B?dVRURUY5TG5NMkVNNUtQdmdURXo4WWM0YlBEa05kVktnRlFjcS85SmVGaVNS?=
 =?utf-8?B?Q2laQmMrT0dUODBwZ253eW92bzZvKzRVN0RvK0k2MXlrNzhGVEh1SmJDSUQz?=
 =?utf-8?B?QzVQRlYyNFRPNUJXQ05teTBRMDV2ZUJBV1M0WklXMjZLVFE1S0paWnh2MTFV?=
 =?utf-8?B?ZDYxMHNWc1RBWXNUZGhHd3hmOGhqclBkVWUrbDdFWkg2UEU4cDE4bGQwRTMw?=
 =?utf-8?B?OEVjK2JuQ2dLTXZzeHRvZm42TTJ4QW5qamRCYzBzTEYrTVNhWUw0LzlNdTlL?=
 =?utf-8?B?OXhqVHpnOXBQYlZjcWRWRmdtejB4aTFmOWN3MTlPZWI3aU1IR3puQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d10a31-6c1c-4dea-8324-08deaa8dd656
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 10:05:30.2969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VL8jQbtg/WrYiHB3MTqbPQxj8qOVjoyGLWXEx8yv4lVic8kErny9v+y2AB4gWsKMJunR4iVY7HxJMUlIHEs3RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11083
X-Rspamd-Queue-Id: 9D5E34CAA0A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,linux.dev,bootlin.com,samsung.com,lunn.ch,intel.com,rock-chips.com,acm.org,google.com,quicinc.com,tuxon.dev,gmail.com,davemloft.net,nxp.com,glider.be,linuxfoundation.org,sntech.de,amarulasolutions.com,HansenPartnership.com,nvidia.com,perches.com,kwiboo.se,starfivetech.com,oss.qualcomm.com,ideasonboard.com,linux.intel.com,pengutronix.de,somainline.org,baylibre.com,oracle.com,renesas.com,redhat.com,armlinux.org.uk,sholland.org,poorly.run,ffwll.ch,synopsys.com,suse.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7489-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCPT_COUNT_GT_50(0.00)[105];
	TAGGED_RCPT(0.00)[linux-can,netdev,renesas,linaro,kernel];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

The biggest problem requiring this split is the fact that consumer
drivers poke around in struct phy, accessing fields which shouldn't be
visible to them. Follow the example of mux, gpio, iio, spi offload,
pwrsec, pinctrl and regulator, which each expose separate headers for
consumers and providers.

Some off-list discussions were had with Vinod Koul regarding the 3 PHY
providers outside the drivers/phy/ subsystem. It was agreed that it is
desirable to relocate them to drivers/phy/, rather than to publish
phy-provider.h to include/linux/phy/ for liberal use. Only phy.h and
(new) phy-props.h - consumer-facing headers - stay there.

The hope is that developers get a hint when they need to include the
wrong header to get their job done.

If that fails, patch 31/31 adds a regex in the MAINTAINERS entry that
ensures linux-phy is copied on all Generic PHY patches, for an extra set
of eyes.

Requested merge strategy, I hope this works for everyone:
- Subsystem maintainers ACK their affected portions
- Entire series goes through linux-phy/next (v7.1-rc1)
- linux-phy provides stable tag
- (optionally, but recommended) Said tag is merged back into affected
  subsystem 'next' branches. Those who strongly prefer can handle merge
  conflicts when they send their PR. But this series unexports a lot of
  stuff from <linux/phy/phy.h> which may cause breakage if still used
  later, directly or not, in other subsystems.

Detailed change log in patches, summary below.

v7->v8:
- new "[PATCH v8 phy-next 01/31] PCI: cadence: Preserve all error codes
  in cdns_plat_pcie_probe()" to fix pre-existing issue found by Sashiko
- bring commit message details more in line with actual code changes
  (reported by Sashiko)
- completely rewrote Exynos UFS patch (10/31), introducing new
  phy_request_bus_width() consumer API (also updated regex pattern in
  MAINTAINERS). Issues with previous approach
  reported by Sashiko.
- completely rewrote Qualcomm UFS patches, included 3 untested changes
  previously sent to Manivannan Sadhasivam during v5
- move ulpi_phy.h from include/linux/phy/ to drivers/phy/
- make "struct phy *" argument const for new phy_get_max_link_rate() API
  function, but not for existing API functions. From Geert Uytterhoeven.
- updated all patches to clarify that phy_set_bus_width() is intended as
  a provider-only function.
- Bug fixes pointed out by Sashiko in Tegra XUDC and XUSB drivers
- expanded CC list coverage for UFS changes
v6->v7:
- "[PATCH v6 phy-next 15/28] drm/msm/dp: remove debugging prints with
  internal struct phy state" merged separately:
  https://lore.kernel.org/linux-phy/okmmblz53sdgjwduiszsyo5l2hcqnxm3xq5yojbi6uxp7kmojm@jaz2a34av7ww/#t
- rebase onto v7.1-rc1
- fix new fallout in drivers/usb/dwc3/dwc3-imx.c (patch 04/31) due to
  crossing paths with new driver
v5->v6:
- new patch 14/31 to avoid build breakage in ufs-qcom.c for armv7
- expanded CC list coverage
v4->v5:
- fix additional compilation breakage caught by better build coverage.
  PCI patch 02/27 received an extra change for pcie-spacemit-k1.c,
  patch 10/27 (for ufs-qcom.c) is new, so are 12/27 and 13/27 for Tegra
  USB (host and gadget)
v3->v4:
- fix build breakage in drivers/phy/qualcomm/phy-qcom-ipq806x-sata.c and
  include/linux/phy/tegra/xusb.h added by patch 22/24
v2->v3:
- remove unused variable in PCI after device link removal
- update MAINTAINERS regex pattern to escape forward slashes
- add more people to CC list
- provide conflict resolution
v1->v2:
- split "phy: include PHY provider header" into smaller chunks to work
  around mailing list moderation due to patch size
- improve MAINTAINERS regex pattern
- make all PHY attribute helpers NULL-tolerant. Not just the new
  phy_get_bus_width(), but also retroactively, the existing ones.
- fixed the temporary include path from <linux/phy/phy.h> to
  "phy-provider.h", removed anyway by the end of the series
- logical bug fixes in the PCI controller <-> PHY device link removal
  and Exynos UFS PHY API rework

In case anyone wants to test the series, here it is on top of linux-phy/next:
https://github.com/vladimiroltean/linux/tree/phy-split-consumer-provider-v8

v7 at:
https://lore.kernel.org/linux-phy/20260430110652.558622-1-vladimir.oltean@nxp.com/
v6 at:
https://lore.kernel.org/linux-phy/20260327184706.1600329-1-vladimir.oltean@nxp.com/
v5 at:
https://lore.kernel.org/linux-phy/20260319223241.1351137-1-vladimir.oltean@nxp.com/
v4 at:
https://lore.kernel.org/linux-phy/20260317230500.2056077-1-vladimir.oltean@nxp.com/
v3 at:
https://lore.kernel.org/linux-phy/20260309190842.927634-1-vladimir.oltean@nxp.com/
v2 at:
https://lore.kernel.org/linux-phy/20260308114009.2546587-1-vladimir.oltean@nxp.com/
v1 at:
https://lore.kernel.org/linux-phy/20260304175735.2660419-13-vladimir.oltean@nxp.com/

Cc: Abhinav Kumar <abhinav.kumar@linux.dev>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>
Cc: "André Draszik" <andre.draszik@linaro.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Andy Yan <andy.yan@rock-chips.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Can Guo <quic_cang@quicinc.com>
Cc: Chanho Park <chanho61.park@samsung.com>
Cc: Chen-Yu Tsai <wens@kernel.org>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Daniel Machon <daniel.machon@microchip.com>
Cc: David Airlie <airlied@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Dmitry Baryshkov <lumag@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Heiko Stübner" <heiko@sntech.de>
Cc: Inki Dae <inki.dae@samsung.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: JC Kuo <jckuo@nvidia.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Jessica Zhang <jesszhan0024@gmail.com>
Cc: Joe Perches <joe@perches.com>
Cc: Johan Hovold <johan+linaro@kernel.org>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Kevin Xie <kevin.xie@starfivetech.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Linus Walleij <linusw@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Michael Dege <michael.dege@renesas.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Niklas Cassel <cassel@kernel.org>
Cc: Nitin Rawat <quic_nitirawa@quicinc.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Peter Chen <peter.chen@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: Robert Foss <rfoss@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Samuel Holland <samuel@sholland.org>
Cc: Sandy Huang <hjc@rock-chips.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Sean Paul <sean@poorly.run>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Steen Hegelund <Steen.Hegelund@microchip.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Vincent Mailhol <mailhol@kernel.org>
Cc: Xu Yang <xu.yang_2@nxp.com>
Cc: Yixun Lan <dlan@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Vladimir Oltean (31):
  PCI: cadence: Preserve all error codes in cdns_plat_pcie_probe()
  ata: add <linux/pm_runtime.h> where missing
  PCI: Add missing headers transitively included by <linux/phy/phy.h>
  usb: add missing headers transitively included by <linux/phy/phy.h>
  drm: add <linux/pm_runtime.h> where missing
  phy: add <linux/pm_runtime.h> where missing
  phy: spacemit: include missing <linux/phy/phy.h>
  net: lan969x: include missing <linux/of.h>
  PCI: Remove device links to PHY
  scsi: ufs: exynos: use dedicated API for updating PHY bus width
  scsi: ufs: qcom: call phy_init() before phy_power_on()
  scsi: ufs: qcom: make use of QMP PHY dynamic gear switching ability
  scsi: ufs: qcom: keep separate track of PHY power state
  scsi: ufs: qcom: include missing <linux/interrupt.h>
  drm/rockchip: dw_hdmi: avoid direct dereference of phy->dev.of_node
  usb: host: tegra: avoid direct dereference of phy->dev.of_node
  usb: gadget: tegra-xudc: avoid direct dereference of phy->dev.of_node
  phy: move provider API out of public <linux/phy/phy.h>
  phy: make phy_get_mode(), phy_get_bus_width() NULL tolerant
  phy: introduce phy_get_max_link_rate() helper for consumers
  drm/rockchip: dsi: include PHY provider header
  drm: bridge: cdns-mhdp8546: use consumer API for getting PHY bus width
  media: sunxi: a83-mips-csi2: include PHY provider header
  net: renesas: rswitch: include PHY provider header
  pinctrl: tegra-xusb: include PHY provider header
  power: supply: cpcap-charger: include missing <linux/property.h>
  phy: move ulpi_phy.h from include/linux/phy/ to drivers/phy/
  phy: include PHY provider header (1/2)
  phy: include PHY provider header (2/2)
  phy: remove temporary provider compatibility from consumer header
  MAINTAINERS: add regexes for linux-phy

 MAINTAINERS                                   |  12 +
 drivers/ata/ahci.c                            |   1 +
 drivers/ata/ahci_brcm.c                       |   1 +
 drivers/ata/ahci_ceva.c                       |   1 +
 drivers/ata/ahci_qoriq.c                      |   1 +
 drivers/ata/libahci.c                         |   1 +
 .../drm/bridge/analogix/analogix_dp_core.c    |   1 +
 .../drm/bridge/cadence/cdns-mhdp8546-core.c   |   7 +-
 drivers/gpu/drm/bridge/nwl-dsi.c              |   1 +
 drivers/gpu/drm/bridge/samsung-dsim.c         |   1 +
 drivers/gpu/drm/bridge/synopsys/dw-dp.c       |   2 +-
 drivers/gpu/drm/msm/dp/dp_aux.c               |   1 +
 drivers/gpu/drm/rockchip/cdn-dp-core.c        |   1 +
 .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   |   1 +
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c   |  25 +-
 .../sun8i-a83t-mipi-csi2/sun8i_a83t_dphy.c    |   2 +-
 drivers/net/can/at91_can.c                    |   3 +-
 drivers/net/can/flexcan/flexcan-core.c        |   3 +-
 drivers/net/can/m_can/m_can_platform.c        |   3 +-
 drivers/net/can/rcar/rcar_canfd.c             |   3 +-
 .../microchip/sparx5/lan969x/lan969x_rgmii.c  |   1 +
 drivers/net/ethernet/renesas/rswitch_main.c   |   1 +
 .../controller/cadence/pcie-cadence-plat.c    |   6 +-
 drivers/pci/controller/cadence/pcie-cadence.c |  16 +-
 drivers/pci/controller/cadence/pcie-cadence.h |   2 -
 drivers/pci/controller/dwc/pci-dra7xx.c       |  16 -
 drivers/pci/controller/dwc/pci-keystone.c     |  32 +-
 drivers/pci/controller/dwc/pcie-dw-rockchip.c |   1 +
 drivers/pci/controller/dwc/pcie-histb.c       |   1 +
 drivers/pci/controller/dwc/pcie-qcom-ep.c     |   1 +
 drivers/pci/controller/dwc/pcie-spacemit-k1.c |   3 +
 drivers/pci/controller/dwc/pcie-tegra194.c    |   1 +
 drivers/pci/controller/pci-tegra.c            |   1 +
 drivers/pci/controller/pcie-rockchip-host.c   |   1 +
 drivers/pci/controller/plda/pcie-starfive.c   |   1 +
 drivers/phy/allwinner/phy-sun4i-usb.c         |   3 +-
 drivers/phy/allwinner/phy-sun50i-usb3.c       |   3 +-
 drivers/phy/allwinner/phy-sun6i-mipi-dphy.c   |   4 +-
 drivers/phy/allwinner/phy-sun9i-usb.c         |   3 +-
 drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c |   2 +
 .../amlogic/phy-meson-axg-mipi-pcie-analog.c  |   3 +-
 drivers/phy/amlogic/phy-meson-axg-pcie.c      |   2 +
 .../amlogic/phy-meson-g12a-mipi-dphy-analog.c |   3 +-
 drivers/phy/amlogic/phy-meson-g12a-usb2.c     |   3 +-
 .../phy/amlogic/phy-meson-g12a-usb3-pcie.c    |   3 +-
 drivers/phy/amlogic/phy-meson-gxl-usb2.c      |   3 +-
 drivers/phy/amlogic/phy-meson8-hdmi-tx.c      |   3 +-
 drivers/phy/amlogic/phy-meson8b-usb2.c        |   3 +-
 drivers/phy/apple/atc.c                       |   3 +-
 drivers/phy/broadcom/phy-bcm-cygnus-pcie.c    |   3 +-
 drivers/phy/broadcom/phy-bcm-kona-usb2.c      |   3 +-
 drivers/phy/broadcom/phy-bcm-ns-usb2.c        |   3 +-
 drivers/phy/broadcom/phy-bcm-ns-usb3.c        |   3 +-
 drivers/phy/broadcom/phy-bcm-ns2-pcie.c       |   3 +-
 drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c     |   3 +-
 drivers/phy/broadcom/phy-bcm-sr-pcie.c        |   3 +-
 drivers/phy/broadcom/phy-bcm-sr-usb.c         |   3 +-
 drivers/phy/broadcom/phy-bcm63xx-usbh.c       |   3 +-
 drivers/phy/broadcom/phy-brcm-sata.c          |   3 +-
 drivers/phy/broadcom/phy-brcm-usb.c           |   2 +-
 drivers/phy/cadence/cdns-dphy-rx.c            |   3 +-
 drivers/phy/cadence/cdns-dphy.c               |   4 +-
 drivers/phy/cadence/phy-cadence-salvo.c       |   3 +-
 drivers/phy/cadence/phy-cadence-sierra.c      |   3 +-
 drivers/phy/cadence/phy-cadence-torrent.c     |   3 +-
 drivers/phy/canaan/phy-k230-usb.c             |   3 +-
 drivers/phy/eswin/phy-eic7700-sata.c          |   3 +-
 .../phy/freescale/phy-fsl-imx8-mipi-dphy.c    |   3 +-
 drivers/phy/freescale/phy-fsl-imx8m-pcie.c    |   4 +-
 drivers/phy/freescale/phy-fsl-imx8mq-usb.c    |   3 +-
 drivers/phy/freescale/phy-fsl-imx8qm-hsio.c   |   6 +-
 .../phy/freescale/phy-fsl-imx8qm-lvds-phy.c   |   3 +-
 drivers/phy/freescale/phy-fsl-lynx-28g.c      |   3 +-
 drivers/phy/hisilicon/phy-hi3660-usb3.c       |   3 +-
 drivers/phy/hisilicon/phy-hi3670-pcie.c       |   3 +-
 drivers/phy/hisilicon/phy-hi3670-usb3.c       |   3 +-
 drivers/phy/hisilicon/phy-hi6220-usb.c        |   3 +-
 drivers/phy/hisilicon/phy-hisi-inno-usb2.c    |   3 +-
 drivers/phy/hisilicon/phy-histb-combphy.c     |   3 +-
 drivers/phy/hisilicon/phy-hix5hd2-sata.c      |   3 +-
 drivers/phy/ingenic/phy-ingenic-usb.c         |   3 +-
 drivers/phy/intel/phy-intel-keembay-emmc.c    |   3 +-
 drivers/phy/intel/phy-intel-keembay-usb.c     |   3 +-
 drivers/phy/intel/phy-intel-lgm-combo.c       |   4 +-
 drivers/phy/intel/phy-intel-lgm-emmc.c        |   3 +-
 drivers/phy/lantiq/phy-lantiq-rcu-usb2.c      |   3 +-
 drivers/phy/lantiq/phy-lantiq-vrx200-pcie.c   |   4 +-
 drivers/phy/marvell/phy-armada375-usb2.c      |   3 +-
 drivers/phy/marvell/phy-armada38x-comphy.c    |   3 +-
 drivers/phy/marvell/phy-berlin-sata.c         |   3 +-
 drivers/phy/marvell/phy-berlin-usb.c          |   3 +-
 drivers/phy/marvell/phy-mmp3-hsic.c           |   3 +-
 drivers/phy/marvell/phy-mmp3-usb.c            |   3 +-
 drivers/phy/marvell/phy-mvebu-a3700-comphy.c  |   3 +-
 drivers/phy/marvell/phy-mvebu-a3700-utmi.c    |   3 +-
 drivers/phy/marvell/phy-mvebu-cp110-comphy.c  |   3 +-
 drivers/phy/marvell/phy-mvebu-cp110-utmi.c    |   3 +-
 drivers/phy/marvell/phy-mvebu-sata.c          |   3 +-
 drivers/phy/marvell/phy-pxa-28nm-hsic.c       |   3 +-
 drivers/phy/marvell/phy-pxa-28nm-usb2.c       |   3 +-
 drivers/phy/marvell/phy-pxa-usb.c             |   3 +-
 drivers/phy/mediatek/phy-mtk-dp.c             |   3 +-
 drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c    |   1 -
 drivers/phy/mediatek/phy-mtk-hdmi.h           |   3 +-
 drivers/phy/mediatek/phy-mtk-mipi-csi-0-5.c   |   2 +-
 drivers/phy/mediatek/phy-mtk-mipi-dsi.h       |   3 +-
 drivers/phy/mediatek/phy-mtk-pcie.c           |   2 +-
 drivers/phy/mediatek/phy-mtk-tphy.c           |   2 +-
 drivers/phy/mediatek/phy-mtk-ufs.c            |   2 +-
 drivers/phy/mediatek/phy-mtk-xfi-tphy.c       |   2 +-
 drivers/phy/mediatek/phy-mtk-xsphy.c          |   2 +-
 drivers/phy/microchip/lan966x_serdes.c        |   4 +-
 drivers/phy/microchip/sparx5_serdes.c         |   2 +-
 drivers/phy/motorola/phy-cpcap-usb.c          |   3 +-
 drivers/phy/motorola/phy-mapphone-mdm6600.c   |   5 +-
 drivers/phy/mscc/phy-ocelot-serdes.c          |   3 +-
 drivers/phy/nuvoton/phy-ma35d1-usb2.c         |   3 +-
 drivers/phy/phy-airoha-pcie.c                 |   2 +-
 drivers/phy/phy-can-transceiver.c             |   3 +-
 drivers/phy/phy-core-mipi-dphy.c              |   4 +-
 drivers/phy/phy-core.c                        |  80 +++
 drivers/phy/phy-google-usb.c                  |   4 +-
 drivers/phy/phy-lpc18xx-usb-otg.c             |   3 +-
 drivers/phy/phy-nxp-ptn3222.c                 |   3 +-
 drivers/phy/phy-pistachio-usb.c               |   4 +-
 drivers/phy/phy-provider.h                    | 263 +++++++++
 drivers/phy/phy-snps-eusb2.c                  |   2 +
 drivers/phy/phy-xgene.c                       |   3 +-
 drivers/phy/qualcomm/phy-ath79-usb.c          |   3 +-
 drivers/phy/qualcomm/phy-qcom-apq8064-sata.c  |   3 +-
 drivers/phy/qualcomm/phy-qcom-edp.c           |   3 +-
 .../phy/qualcomm/phy-qcom-eusb2-repeater.c    |   3 +-
 drivers/phy/qualcomm/phy-qcom-ipq4019-usb.c   |   3 +-
 drivers/phy/qualcomm/phy-qcom-ipq806x-sata.c  |   3 +-
 drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c   |   3 +-
 drivers/phy/qualcomm/phy-qcom-m31-eusb2.c     |   2 +
 drivers/phy/qualcomm/phy-qcom-m31.c           |   3 +-
 drivers/phy/qualcomm/phy-qcom-pcie2.c         |   3 +-
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c     |   4 +-
 .../phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c  |   3 +-
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      |   3 +-
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c       |   9 +-
 .../phy/qualcomm/phy-qcom-qmp-usb-legacy.c    |   4 +-
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c       |   4 +-
 drivers/phy/qualcomm/phy-qcom-qmp-usbc.c      |   4 +-
 drivers/phy/qualcomm/phy-qcom-qusb2.c         |   5 +-
 drivers/phy/qualcomm/phy-qcom-sgmii-eth.c     |   3 +-
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c |   4 +-
 .../phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c  |   3 +-
 drivers/phy/qualcomm/phy-qcom-usb-hs-28nm.c   |   3 +-
 drivers/phy/qualcomm/phy-qcom-usb-hs.c        |   3 +-
 drivers/phy/qualcomm/phy-qcom-usb-hsic.c      |   3 +-
 drivers/phy/qualcomm/phy-qcom-usb-ss.c        |   3 +-
 drivers/phy/ralink/phy-mt7621-pci.c           |   3 +-
 drivers/phy/ralink/phy-ralink-usb.c           |   3 +-
 drivers/phy/realtek/phy-rtk-usb2.c            |   3 +-
 drivers/phy/realtek/phy-rtk-usb3.c            |   3 +-
 drivers/phy/renesas/phy-rcar-gen2.c           |   3 +-
 drivers/phy/renesas/phy-rcar-gen3-pcie.c      |   4 +-
 drivers/phy/renesas/phy-rcar-gen3-usb2.c      |   3 +-
 drivers/phy/renesas/phy-rcar-gen3-usb3.c      |   3 +-
 drivers/phy/renesas/phy-rzg3e-usb3.c          |   3 +-
 drivers/phy/renesas/r8a779f0-ether-serdes.c   |   4 +-
 drivers/phy/rockchip/phy-rockchip-dp.c        |   3 +-
 drivers/phy/rockchip/phy-rockchip-dphy-rx0.c  |   3 +-
 drivers/phy/rockchip/phy-rockchip-emmc.c      |   3 +-
 .../phy/rockchip/phy-rockchip-inno-csidphy.c  |   3 +-
 .../phy/rockchip/phy-rockchip-inno-dsidphy.c  |   4 +-
 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c |   4 +-
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c |   3 +-
 .../rockchip/phy-rockchip-naneng-combphy.c    |   3 +-
 drivers/phy/rockchip/phy-rockchip-pcie.c      |   2 +-
 .../phy/rockchip/phy-rockchip-samsung-dcphy.c |   3 +-
 .../phy/rockchip/phy-rockchip-samsung-hdptx.c |   4 +-
 .../phy/rockchip/phy-rockchip-snps-pcie3.c    |   3 +-
 drivers/phy/rockchip/phy-rockchip-typec.c     |   5 +-
 drivers/phy/rockchip/phy-rockchip-usb.c       |   3 +-
 drivers/phy/rockchip/phy-rockchip-usbdp.c     |   3 +-
 drivers/phy/samsung/phy-exynos-dp-video.c     |   3 +-
 drivers/phy/samsung/phy-exynos-mipi-video.c   |   3 +-
 drivers/phy/samsung/phy-exynos-pcie.c         |   3 +-
 drivers/phy/samsung/phy-exynos4210-usb2.c     |   3 +-
 drivers/phy/samsung/phy-exynos4x12-usb2.c     |   3 +-
 drivers/phy/samsung/phy-exynos5-usbdrd.c      |   2 +
 drivers/phy/samsung/phy-exynos5250-sata.c     |   3 +-
 drivers/phy/samsung/phy-exynos5250-usb2.c     |   3 +-
 drivers/phy/samsung/phy-s5pv210-usb2.c        |   3 +-
 drivers/phy/samsung/phy-samsung-ufs.c         |  29 +-
 drivers/phy/samsung/phy-samsung-ufs.h         |   3 +-
 drivers/phy/samsung/phy-samsung-usb2.c        |   3 +-
 drivers/phy/samsung/phy-samsung-usb2.h        |   3 +-
 drivers/phy/socionext/phy-uniphier-ahci.c     |   3 +-
 drivers/phy/socionext/phy-uniphier-pcie.c     |   3 +-
 drivers/phy/socionext/phy-uniphier-usb2.c     |   3 +-
 drivers/phy/socionext/phy-uniphier-usb3hs.c   |   3 +-
 drivers/phy/socionext/phy-uniphier-usb3ss.c   |   3 +-
 drivers/phy/sophgo/phy-cv1800-usb2.c          |   3 +-
 drivers/phy/spacemit/phy-k1-pcie.c            |   4 +-
 drivers/phy/spacemit/phy-k1-usb2.c            |   2 +
 drivers/phy/st/phy-miphy28lp.c                |   4 +-
 drivers/phy/st/phy-spear1310-miphy.c          |   3 +-
 drivers/phy/st/phy-spear1340-miphy.c          |   3 +-
 drivers/phy/st/phy-stih407-usb.c              |   3 +-
 drivers/phy/st/phy-stm32-combophy.c           |   3 +-
 drivers/phy/st/phy-stm32-usbphyc.c            |   3 +-
 drivers/phy/starfive/phy-jh7110-dphy-rx.c     |   3 +-
 drivers/phy/starfive/phy-jh7110-dphy-tx.c     |   3 +-
 drivers/phy/starfive/phy-jh7110-pcie.c        |   3 +-
 drivers/phy/starfive/phy-jh7110-usb.c         |   3 +-
 drivers/phy/sunplus/phy-sunplus-usb2.c        |   3 +-
 drivers/phy/tegra/phy-tegra194-p2u.c          |   3 +-
 drivers/phy/tegra/xusb-tegra124.c             |   2 +-
 drivers/phy/tegra/xusb-tegra186.c             |   2 +-
 drivers/phy/tegra/xusb-tegra210.c             |   2 +-
 drivers/phy/tegra/xusb.c                      |   2 +-
 drivers/phy/ti/phy-am654-serdes.c             |   3 +-
 drivers/phy/ti/phy-da8xx-usb.c                |   3 +-
 drivers/phy/ti/phy-dm816x-usb.c               |   3 +-
 drivers/phy/ti/phy-gmii-sel.c                 |   3 +-
 drivers/phy/ti/phy-omap-usb2.c                |   3 +-
 drivers/phy/ti/phy-ti-pipe3.c                 |   3 +-
 drivers/phy/ti/phy-tusb1210.c                 |   4 +-
 drivers/phy/ti/phy-twl4030-usb.c              |   3 +-
 {include/linux => drivers}/phy/ulpi_phy.h     |   2 +-
 drivers/phy/xilinx/phy-zynqmp.c               |   4 +-
 drivers/pinctrl/tegra/pinctrl-tegra-xusb.c    |   2 +-
 drivers/power/supply/cpcap-charger.c          |   1 +
 drivers/ufs/host/ufs-exynos.c                 | 114 ++--
 drivers/ufs/host/ufs-exynos.h                 |   1 +
 drivers/ufs/host/ufs-qcom.c                   |  99 ++--
 drivers/ufs/host/ufs-qcom.h                   |   1 +
 drivers/usb/chipidea/ci_hdrc_imx.c            |   1 +
 drivers/usb/core/hcd.c                        |   1 +
 drivers/usb/dwc3/dwc3-generic-plat.c          |   1 +
 drivers/usb/dwc3/dwc3-imx.c                   |   1 +
 drivers/usb/dwc3/gadget.c                     |   1 +
 drivers/usb/gadget/udc/tegra-xudc.c           |  43 +-
 drivers/usb/host/xhci-tegra.c                 |  43 +-
 include/linux/phy/phy-props.h                 |  75 +++
 include/linux/phy/phy-sun4i-usb.h             |   2 +-
 include/linux/phy/phy.h                       | 497 ++++--------------
 include/linux/phy/tegra/xusb.h                |   1 +
 242 files changed, 1188 insertions(+), 799 deletions(-)
 create mode 100644 drivers/phy/phy-provider.h
 rename {include/linux => drivers}/phy/ulpi_phy.h (96%)
 create mode 100644 include/linux/phy/phy-props.h

-- 
2.34.1


