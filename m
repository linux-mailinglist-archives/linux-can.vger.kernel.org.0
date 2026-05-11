Return-Path: <linux-can+bounces-7590-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAW4KrecAWoHggEAu9opvQ
	(envelope-from <linux-can+bounces-7590-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 11 May 2026 11:09:11 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2391450AA12
	for <lists+linux-can@lfdr.de>; Mon, 11 May 2026 11:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0305730578EB
	for <lists+linux-can@lfdr.de>; Mon, 11 May 2026 09:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D853C1976;
	Mon, 11 May 2026 09:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="zjyx8z06"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560D83C3C0B
	for <linux-can@vger.kernel.org>; Mon, 11 May 2026 09:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778490042; cv=none; b=rCHdik3V7iQW8I1BqQjJAWRQDnl4+TYBHRrlp1ephhbuPGMb9kmx1VLYzfoRoGc6983OT7nBD2X2Tg5XMuv8hEyLsOQnlZmg1+FhmK24zvF6lk7xWfcNDulzQn5r249wMpg8PPTWeqyqUfz8vGLYqzbzrhAkJAEEZtq5rieH/Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778490042; c=relaxed/simple;
	bh=ZYGinJLF1cDgGH/aGo4d1Hy0fwsOtdFNgDp8EWspf48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=augHO3VjqlDCRxFx5twXokRFa6l6VtEwSsYge5oFylOLbdYuK9A3DekTsx0kCa7BHmyi/Uf3SCTI3LwFJ8Vq1HyQt0jYKowChAa9cx+H2NEHu4+9/SmQX9UiKNwfem8PI7bMAEfm1E+ij2gnMMmrC1ODh0OO0LmoEsmtIiMgLU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=zjyx8z06; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-444826c16ffso3542538f8f.1
        for <linux-can@vger.kernel.org>; Mon, 11 May 2026 02:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778490038; x=1779094838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zA2t05MaP/podHX+JpTZXPs7rW/q4RVQKoAjNccx6WY=;
        b=zjyx8z06LW5isoT8LCSsXz+IFhYHTCiWyxWpyhQnuRjuxF2yJQkHA7pCKTR9CVv4yV
         1eBHxsGm0obJ3tC+saBHhlRiU09Mm55lQIc7BnqeTKJkwIYBO0WoIpCpDplCe9cWKSYx
         Ujn3uCjpcJsuYsrJ61DoJPPw7O9Ez3liNpKPyQBDaEnlwngLqDr76c5bMk9w5zA5gaAz
         Gn5B0mW6DKzkZSqzk2ARFaS0DDNiSpAq7mbFSKS9viASh8q3Ubibs+uE3hJ2L4SVHS6s
         zErl1L54vHW4glkpYJHJyvqjGfcir95CIXol8XdcDnNJQmnqgTliRKjS46BUvT0CoWlg
         zgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778490038; x=1779094838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zA2t05MaP/podHX+JpTZXPs7rW/q4RVQKoAjNccx6WY=;
        b=i9an4pn9791durJfBnKoTJmfebOZYFGzmDh93j+Bs+G/yhyOyRLvYa0pch8Z24ZHm/
         IfmbBX7FaRQG+LOXAidwmNm68rLJTQB9ub5XbyeI74Zd1PSmkCeGJRL+oImz1eUmZlH/
         QW1V9Giwo6NTF3ChbcxwFD6oqpaM2i/V1ZsmW+ErIZvEXz5KNvLLfOANeibCJYBA3QuQ
         8BPg+uj8NDNuI7R2aeqdD5WKVXP8RtuhcOdiqXLqSZpUfT+BzmNPvT7MbMNKVHhONx7N
         7tcd9Fi2Om4nJ+r7+y+dd3xj/pDYZQRorkkW75jbXbkeEYQzOBTberk3h0xrP/aaTg8z
         vtIQ==
X-Forwarded-Encrypted: i=1; AFNElJ+1abg4dPRYBXaKlLkLWy8W83qBD1IwqEL4pq9EODNEkeTS2PPuHY34L2PV/BO5LoK4jgLwmCPGRBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyys0cN4nJwrNRWehmqqS3tyMEQuEsNT0FCgKNMTg/KVY1exoeD
	UXgJ4zoF2wiIiYzXQIxwyrR0TRz8fXoMs686kf+plfFQ1bCjHujfKW647R+DoAUJon0=
X-Gm-Gg: Acq92OH0ARSeDQleTvjQXhCETHGas4Woxs35C73oy9Frz1IVO/rqX+IL/CkJ2Skn7HE
	37xO374NF3Ox6P4wrVqjHNjH21L+qdjbqhlA7NuortvTjzxwoaAMK4YUtusGvBG1jWwayb26MhZ
	sKgLMfgpEBUu7jc8I0PkjC3lbdOd6sZ6XMXdgvnPVRyWCANyR38zZDj/IKAoNQrQSCAxf7Lv97d
	ZSakjBp6KggvBlgetGn4oGIEBDKdWRs29gU4IRssIIjID1+f0eWN5rhImFhPMr1EUoZLSzyX/wg
	WQY3D4UZvWSHK+HonYyBZfyTRwwczi1+065nknyegrq6dafCJXXFxhySE6U9VZoy0kJIaVqpv1A
	dOjsS7IpGea5qsrb/nJdYrH1YvsmY0VuWpdAbPNqj3mdiIUqwRVWeoWt8UlSi3V9gjzj+pS1ejP
	2Ws3NUzGCu9DuzqGs6OnqlaAgMCEoSdi8OE7IXZhvKiv3W0ihzhTDJnCDpLM8AXxdnQVN862wZw
	M5xB5P+nuMTtFemo+UoNAmQbg==
X-Received: by 2002:a5d:64e3:0:b0:449:cfea:ca91 with SMTP id ffacd0b85a97d-4515da96254mr34460937f8f.37.1778490037223;
        Mon, 11 May 2026 02:00:37 -0700 (PDT)
Received: from localhost (p200300f65f114e0841c796eda31a14b3.dip0.t-ipconnect.de. [2003:f6:5f11:4e08:41c7:96ed:a31a:14b3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4548e6a5b65sm25209225f8f.8.2026.05.11.02.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 02:00:36 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Michael Grzeschik <mgr@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Steffen Klassert <klassert@kernel.org>,
	David Dillow <dave@thedillows.org>,
	Ion Badulescu <ionut@badula.org>,
	Mark Einon <mark.einon@gmail.com>,
	Rasesh Mody <rmody@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com,
	Manish Chopra <manishc@marvell.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Denis Kirjanov <kirjanov@gmail.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Jian Shen <shenjian15@huawei.com>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	Fan Gong <gongfan1@huawei.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Yibo Dong <dong100@mucse.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	nic_swsd@realtek.com,
	Jiri Pirko <jiri@resnulli.us>,
	Francois Romieu <romieu@fr.zoreil.com>,
	Daniele Venzano <venza@brownhat.org>,
	Samuel Chessman <chessman@tux.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Kevin Curtis <kevin.curtis@farsite.co.uk>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Stanislav Yakovlev <stas.yakovlev@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Thomas Fourier <fourier.thomas@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Zilin Guan <zilin@seu.edu.cn>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Arinzon <darinzon@amazon.com>,
	Yeounsu Moon <yyyynoom@gmail.com>,
	Denis Benato <benato.denis96@gmail.com>,
	Yonglong Liu <liuyonglong@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yicong Hui <yiconghui@gmail.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Ian Lin <ian.lin@infineon.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Double Lo <double.lo@cypress.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	oss-drivers@corigine.com,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com
Subject: [PATCH net-next v3 0/2] Rework pci_device_id initialisation
Date: Mon, 11 May 2026 11:00:22 +0200
Message-ID: <20260511090023.1634387-4-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4853; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=ZYGinJLF1cDgGH/aGo4d1Hy0fwsOtdFNgDp8EWspf48=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqAZqnnelkHiCtzmBC4y0fb7vJdPOE1eZ7YhPdE 2SrLv8jYlGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCagGapwAKCRCPgPtYfRL+ TjAaB/4oo4PlfsIbeG6MCk6KG/Z4+gxMxrSewie9L+e4GgVdrB4TOBKkquVHmIZGwKjcVZ4TTHb NefjSqaVMX4GAGFyvubu+IYDalSlSnAzan/1cuw698pTu8HJAZcUiXsULIZGAzyccgEjFzFRtOG 9zcX6kiJPNLHyc4KCm8r2nVxLqV6bD0Ra/lsh4CIqsXdKbNgT8R/zlx5qsBD4jv6XuZojWf/47T BGjl0kKv9jdWqI2IyZT+iFIbeMxYEcWSMZLzC6lnFeTSGLW7f1AVp8qVTep3xLTu5Qrh0AUeJ60 G6q8VibpIILN8q4yuUlgLX0vBjjeLn9Q8sKtPvNkz+TLgLBC
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2391450AA12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7590-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,thedillows.org,badula.org,gmail.com,marvell.com,chelsio.com,huawei.com,linux.dev,intel.com,nvidia.com,mucse.com,realtek.com,resnulli.us,fr.zoreil.com,brownhat.org,tux.org,trustnetic.com,net-swift.com,farsite.co.uk,broadcom.com,bootlin.com,seu.edu.cn,suse.com,google.com,amazon.com,infradead.org,ti.com,infineon.com,cypress.com,baylibre.com,vger.kernel.org,lists.osuosl.org,corigine.com,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	RCPT_COUNT_GT_50(0.00)[80];
	TAGGED_RCPT(0.00)[linux-can,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,baylibre-com.20251104.gappssmtp.com:dkim,pm.waw.pl:email]
X-Rspamd-Action: no action

Hello,

the previous iteration of this series (v2) is available at
https://lore.kernel.org/netdev/cover.1778149923.git.u.kleine-koenig@baylibre.com

Changes since v2:

 - swap patch order as Jakub Kicinski reported a build failure (that I
   couldn't reproduce though)
 - drop the change to drivers/net/can/m_can/m_can_pci.c on Markus
   Schneider-Pargmann's (non-public) request as this patch conflicts
   with a cleanup he has in his queue that will prepare this driver
   for my quest to add a union to pci_device_id in a differnt way.
 - drop a recipent from Cc: that bounced before (khc@pm.waw.pl).

Best regards
Uwe

Uwe Kleine-König (The Capable Hub) (2):
  net: nfp: Drop PCI class entries with .class_mask = 0
  net: Consistently define pci_device_ids using named initializers

 drivers/net/arcnet/com20020-pci.c             | 242 +++------
 drivers/net/can/sja1000/plx_pci.c             | 167 +++----
 drivers/net/ethernet/3com/3c59x.c             |  80 +--
 drivers/net/ethernet/3com/typhoon.c           |  75 ++-
 drivers/net/ethernet/8390/ne2k-pci.c          |  24 +-
 drivers/net/ethernet/adaptec/starfire.c       |   4 +-
 drivers/net/ethernet/agere/et131x.c           |   6 +-
 drivers/net/ethernet/broadcom/bnx2.c          |  62 ++-
 .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  |  50 +-
 .../net/ethernet/cavium/liquidio/lio_main.c   |  10 +-
 .../ethernet/cavium/liquidio/lio_vf_main.c    |   7 +-
 drivers/net/ethernet/chelsio/cxgb/common.h    |   2 +-
 drivers/net/ethernet/chelsio/cxgb/subr.c      |   2 +-
 .../net/ethernet/chelsio/cxgb3/cxgb3_main.c   |   4 +-
 .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   |   4 +-
 .../ethernet/chelsio/cxgb4vf/cxgb4vf_main.c   |   4 +-
 drivers/net/ethernet/dec/tulip/de2104x.c      |   6 +-
 drivers/net/ethernet/dec/tulip/dmfe.c         |  12 +-
 drivers/net/ethernet/dec/tulip/tulip_core.c   |  78 +--
 drivers/net/ethernet/dec/tulip/uli526x.c      |   6 +-
 drivers/net/ethernet/dec/tulip/winbond-840.c  |  13 +-
 drivers/net/ethernet/dlink/dl2k.h             |  12 +-
 drivers/net/ethernet/dlink/sundance.c         |  14 +-
 drivers/net/ethernet/fealnx.c                 |   8 +-
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c |   2 +-
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |  50 +-
 .../hisilicon/hns3/hns3pf/hclge_main.c        |  18 +-
 .../hisilicon/hns3/hns3vf/hclgevf_main.c      |  12 +-
 .../net/ethernet/huawei/hinic/hinic_main.c    |  12 +-
 .../net/ethernet/huawei/hinic3/hinic3_lld.c   |   7 +-
 drivers/net/ethernet/intel/e100.c             |   9 +-
 drivers/net/ethernet/intel/e1000e/netdev.c    | 471 +++++++++++++-----
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c  |  10 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  59 +--
 drivers/net/ethernet/intel/iavf/iavf_main.c   |  10 +-
 drivers/net/ethernet/intel/igb/igb_main.c     |  66 +--
 drivers/net/ethernet/intel/igbvf/netdev.c     |   4 +-
 drivers/net/ethernet/intel/igc/igc_main.c     |  34 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 106 ++--
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c |  49 +-
 drivers/net/ethernet/mellanox/mlx4/main.c     |   6 +-
 .../net/ethernet/mellanox/mlx5/core/main.c    |  26 +-
 .../net/ethernet/mellanox/mlxsw/spectrum.c    |  16 +-
 drivers/net/ethernet/micrel/ksz884x.c         |   8 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |  10 +-
 drivers/net/ethernet/natsemi/natsemi.c        |   4 +-
 drivers/net/ethernet/netronome/nfp/nfp_main.c |  65 +--
 .../ethernet/netronome/nfp/nfp_netvf_main.c   |  33 +-
 drivers/net/ethernet/qlogic/qede/qede_main.c  |  20 +-
 drivers/net/ethernet/realtek/8139too.c        |  52 +-
 drivers/net/ethernet/realtek/r8169_main.c     |   8 +-
 drivers/net/ethernet/rocker/rocker_main.c     |   4 +-
 drivers/net/ethernet/sis/sis190.c             |   6 +-
 drivers/net/ethernet/sis/sis900.c             |  10 +-
 drivers/net/ethernet/smsc/epic100.c           |  18 +-
 drivers/net/ethernet/sun/cassini.c            |   8 +-
 drivers/net/ethernet/sun/sungem.c             |  26 +-
 drivers/net/ethernet/ti/tlan.c                |  41 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  26 +-
 .../net/ethernet/wangxun/ngbevf/ngbevf_main.c |  26 +-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  18 +-
 .../ethernet/wangxun/txgbevf/txgbevf_main.c   |  18 +-
 drivers/net/wan/farsync.c                     |  24 +-
 drivers/net/wan/pc300too.c                    |  14 +-
 drivers/net/wan/pci200syn.c                   |   6 +-
 drivers/net/wan/wanxl.c                       |  11 +-
 .../broadcom/brcm80211/brcmfmac/pcie.c        |  17 +-
 drivers/net/wireless/intel/ipw2x00/ipw2200.c  |  52 +-
 68 files changed, 1285 insertions(+), 1099 deletions(-)


base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3


