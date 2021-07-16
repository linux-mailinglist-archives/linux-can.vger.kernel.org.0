Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12BBE3CB763
	for <lists+linux-can@lfdr.de>; Fri, 16 Jul 2021 14:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbhGPMhi (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 16 Jul 2021 08:37:38 -0400
Received: from mail-eopbgr10111.outbound.protection.outlook.com ([40.107.1.111]:23886
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237493AbhGPMhi (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 16 Jul 2021 08:37:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4OnXAbuOHGWXd7eOeh1HuXLnX+WhYf1jifqvcX/reTJuLKKmpgkgwzk0f0rzeGNBGGpQQpaZTTGXHllyxzRvXoqoV/mU6cIT/OTyb+OzYDphb3VCSEqliJWxBDuvIgE1fjtiudcWSHjezOH8TvpoLGYhzxyb3YdPT8cV2mAGfLzdP3NKn+1oWCZKpL60GH5fdY0IsOxEK6MylNbfspDUvj8PW2mN3domobn6zqb+GgisUCaURwiXv/CEJiACtqJajmBMloAM8xm06c7N5p31StLsTfKNx7rTQeFtDOmpF8KGrVO/JRm8ZVZTH8mGn/4HW7o2x20QsaZxiX+GSD7yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFjkJeuWq1GNnNagdc7fUIlxsxkHnY5FAnI5NhtbvA8=;
 b=O3PR6qLdysXYK8h9EXEJt9ftcAN5X2f4vHNCEYPSHKTY2Zur9Ifx9CeasKR97Hx11aKhpqPRNORwdaK+Qblc44Z5CNn/8tAYehDnkBLRJ5IXV0ZWvqs5Hi7QllGvwVmhV/3oixvG50pBYP7gSIOVxsLeK5FRN3H67sHc2s1BdERIyW1f7tQhWmdFlpfLA2xbnVsm52X5lrKJnRWLWylYNoItO+fEKy2nxYywSg4u2UZLBhkSlaoS4WVE2n42Mqx1e4WWlq3nJK+xBDghV3eUQ7XxMTWmkTldgFQGiYiZ8cqDShkejY30BC/pLnpwYJd+5Qs95G7fEptfIYrg33hmsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 217.86.141.140) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=esd.eu;
 dmarc=none action=none header.from=esd.eu; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFjkJeuWq1GNnNagdc7fUIlxsxkHnY5FAnI5NhtbvA8=;
 b=Z0QpfbpzzFisiBW7W0QhRGkaL9uEadUgZw9xSISDhvKgoAN5px9sOToTcjDD2AD2kTcLbyHLVmMmdfFEf7EUE0YF37i8v3ts1PzamChd+Xr7KhMz3Yh/VWbjbgwuMHbKzaD8/7paD8mXaalDEyLf+qeJnmAWsAyVWkdn3GlL/0M=
Received: from AS8PR04CA0151.eurprd04.prod.outlook.com (2603:10a6:20b:331::6)
 by AM0PR03MB3873.eurprd03.prod.outlook.com (2603:10a6:208:6f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.25; Fri, 16 Jul
 2021 12:34:40 +0000
Received: from AM7EUR06FT066.eop-eur06.prod.protection.outlook.com
 (2603:10a6:20b:331:cafe::19) by AS8PR04CA0151.outlook.office365.com
 (2603:10a6:20b:331::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend
 Transport; Fri, 16 Jul 2021 12:34:40 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 217.86.141.140) smtp.mailfrom=esd.eu; pengutronix.de; dkim=none (message not
 signed) header.d=none;pengutronix.de; dmarc=none action=none
 header.from=esd.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning esd.eu
 discourages use of 217.86.141.140 as permitted sender)
Received: from esd-s7.esd (217.86.141.140) by
 AM7EUR06FT066.mail.protection.outlook.com (10.233.255.219) with Microsoft
 SMTP Server id 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021
 12:34:40 +0000
Received: from esd-s9.esd.local (unknown [10.0.0.190])
        by esd-s7.esd (Postfix) with ESMTP id B47C77C16C5;
        Fri, 16 Jul 2021 14:34:37 +0200 (CEST)
Received: by esd-s9.esd.local (Postfix, from userid 2044)
        id A7107E00E3; Fri, 16 Jul 2021 14:34:37 +0200 (CEST)
From:   =?UTF-8?q?Stefan=20M=C3=A4tje?= <Stefan.Maetje@esd.eu>
To:     mkl@pengutronix.de
Cc:     o.rempel@pengutronix.de, linux-can@vger.kernel.org
Subject: [PATCH 1/1] can: j1939: j1939_session_tx_dat(): Fix build failure introduced by renaming skcb to se_skcb
Date:   Fri, 16 Jul 2021 14:34:37 +0200
Message-Id: <20210716123437.20825-2-Stefan.Maetje@esd.eu>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20210716123437.20825-1-Stefan.Maetje@esd.eu>
References: <20210716123437.20825-1-Stefan.Maetje@esd.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b46b2b3-e25a-491c-8b35-08d9485614f7
X-MS-TrafficTypeDiagnostic: AM0PR03MB3873:
X-Microsoft-Antispam-PRVS: <AM0PR03MB3873A1C73B987D8A1F693D7F81119@AM0PR03MB3873.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TeC4dZEw/A42boGPSWhLzBVy0T8RAzsZwTYoby+BxInXN3NDJKWY257gNW0HKkvG5PyRUneSmoq7mUhP6SDT0MUfMxP8exAsj2x6DZtoYF2N98shKAHNJKHUnDJ/yiJTsAgoMw7x/h+f0opX0c+7aE6BrfX7oH20xLot6g9OPbbSxcsLcgVMhTMMhtQ1b/+BZ981zj04I3O46Izvd6WGpTGDrLZqBNbYCm50zsZYn5GzAGF0okE86u9JEX44AzLcb1imIxXTZMH3bZOCzGVi7wge5ja/EyixZhNFjD+M4W2Rfw6YU8E6Z+pMtYigOKOcQhCOiqagJBbHX1DWGfUA5VXVM/OUeG0BFopCgv5XBni9ExcQpYNxMJ3WOJUAFdVE1zbWsfgL8kzH90N3oSywtwH7a1LTPLtkSGoTi6vNuFT9TMRlptAFiEPx0CGw/rKw7fNA6E+8b1XCoJFAQPoE1u0AS2H9YkLnpRXUuGKvxUxFlwZzOHRkgJ3mMT1kuYueg9uR48QLg7rRhNCCj5uv6feZhhTaicD5plcyyK4ZK7K6H0jLDHjJOMe+mHXTLjeGCErowAgig0nGa7RZnKafJxlV9gEwuQYjIeLY17EfZeQ/I/wULhZu4k609jHQT9m/w3gU7yNM4y1LYoyyJh+chWftoD+VUN6VOd4tCsx5a57QgwunaW6MygImalgLuPQX2JrZXFzdrHVrG9p663Nnmw==
X-Forefront-Antispam-Report: CIP:217.86.141.140;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:esd-s7.esd;PTR:pd9568d8c.dip0.t-ipconnect.de;CAT:NONE;SFS:(136003)(396003)(376002)(346002)(39830400003)(36840700001)(46966006)(2616005)(26005)(36756003)(82310400003)(47076005)(6266002)(5660300002)(356005)(2906002)(86362001)(8676002)(66574015)(42186006)(4326008)(1076003)(316002)(4744005)(83380400001)(8936002)(70586007)(186003)(70206006)(6916009)(478600001)(81166007)(336012)(36860700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 12:34:40.5020
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b46b2b3-e25a-491c-8b35-08d9485614f7
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b;Ip=[217.86.141.140];Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR06FT066.eop-eur06.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB3873
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The patch a2ea50608a02ac48371a9fab0167c1b44457913e renamed the
session skb control buffer from skcb to se_skcb. But that patch
missed one occurrence of skcb which leads to a build failure.

This patch renames also the last occurrence of skcb to fix it.

Signed-off-by: Stefan Mätje <Stefan.Maetje@esd.eu>
---
 net/can/j1939/transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 6c1d489c8ce2..efdf79de3db6 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -808,7 +808,7 @@ static int j1939_session_tx_dat(struct j1939_session *session)
 		if (offset + len > se_skb->len) {
 			netdev_err_once(priv->ndev,
 					"%s: 0x%p: requested data outside of queued buffer: offset %i, len %i, pkt.tx: %i\n",
-					__func__, session, skcb->offset,
+					__func__, session, se_skcb->offset,
 					se_skb->len , session->pkt.tx);
 			ret = -EOVERFLOW;
 			goto out_free;
-- 
2.25.1

