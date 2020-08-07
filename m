Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D0423E586
	for <lists+linux-can@lfdr.de>; Fri,  7 Aug 2020 03:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgHGBfA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 6 Aug 2020 21:35:00 -0400
Received: from mail-eopbgr760108.outbound.protection.outlook.com ([40.107.76.108]:36736
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726038AbgHGBe7 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 6 Aug 2020 21:34:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TF6I4Gr5Iy/oPaosSllcakiQCkM44x5+Ga78hQYhbTCQUBh5wuKnvvJKlPKhMs+LuU/zAho8Wl/eMeeN7LhJlRWrbnQCKKbxUg4hlPm3toQ11yGjinThlUzQopmYJSLECJNvCOwMD/mDbWjgtfKjSNCDSx+3dCQY2hzdLwDYSYu6V3j5t3yI6+IjsR6GOCXiCw8G/bBhUFoNQNAtdojhENKg1AQW+DpMs4tywAX8O8trZeZAeyQaNh3Tmsf0Kk4VuwF+8IPMxk9uO3p2FnFYsoRLQZtsREAluX7Lb1i+lAG0jpT56RND77PcnGW4pZgQHuQxfwfOJmI9e6xALQLRzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JfIhRH9NU+vdf2lAwsAqaaU60P7XutARGa6AbowRW0=;
 b=NVdbrEl79/TWjZxFX9RM2UddY1fv4MjE6BtCroKs6vvAp2xy7kcZypwKN2pblOd6diMqV8Kq7wxVOhVj1QwdobEQo8W/nwfHLqXAsvkjlPI6ZcY++/xx2ZxA+A/l//APkUACcSKKAjSSfUQbK+raTQB9ReGvW768Hg/Gw6KR7uS7Y2Ink0dvNk0o8qlKnmp6ytNGJ/fuk2fTksHxsAcMcmqr9rZpVIERc1/yDAo7phnNf2PQi+R7Up1WYhRB/auef53aAj6UT79+ZIVb8FwDSK6LbTd6g6/l7AZnnyGO16wOHOIjYQsQYY/mKKtMihRhygz3xvlTm8UOOY/JxRn8kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=optio3.com; dmarc=pass action=none header.from=optio3.com;
 dkim=pass header.d=optio3.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=optio3.onmicrosoft.com; s=selector2-optio3-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JfIhRH9NU+vdf2lAwsAqaaU60P7XutARGa6AbowRW0=;
 b=aB44YNutdmm3k0Pl9mSbGCGttHQbwp2/Kjql8D9ai/9JbQm5AZKEY1eyj7UGDE5f7bMCv3GJMK4qN5uRbw0KhgfaV7BDuYcEhDfE5bkxo93G8ILadrfgmVauvWtuYkoBoKuJHh9/BMphygKTflsrp0zs8x0V1nT9tJ7sggSsEn8=
Authentication-Results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=optio3.com;
Received: from MW3PR12MB4442.namprd12.prod.outlook.com (2603:10b6:303:55::14)
 by MW2PR12MB2556.namprd12.prod.outlook.com (2603:10b6:907:a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.18; Fri, 7 Aug
 2020 01:34:56 +0000
Received: from MW3PR12MB4442.namprd12.prod.outlook.com
 ([fe80::f893:24eb:4ea6:cf13]) by MW3PR12MB4442.namprd12.prod.outlook.com
 ([fe80::f893:24eb:4ea6:cf13%9]) with mapi id 15.20.3239.022; Fri, 7 Aug 2020
 01:34:56 +0000
Date:   Thu, 6 Aug 2020 18:34:54 -0700
From:   Davide Massarenti <davide.m@optio3.com>
To:     dmurphy@ti.com, linux-can@vger.kernel.org
Subject: [PATCH] can: m_can_platform: restore necessary m_can_class_resume()
 call
Message-ID: <20200807013452.GA122904@optio3.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: BYAPR11CA0093.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::34) To MW3PR12MB4442.namprd12.prod.outlook.com
 (2603:10b6:303:55::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from optio3.com (138.91.72.120) by BYAPR11CA0093.namprd11.prod.outlook.com (2603:10b6:a03:f4::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.17 via Frontend Transport; Fri, 7 Aug 2020 01:34:56 +0000
X-Originating-IP: [138.91.72.120]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 991db99e-53b7-472e-994d-08d83a721749
X-MS-TrafficTypeDiagnostic: MW2PR12MB2556:
X-Microsoft-Antispam-PRVS: <MW2PR12MB25567D108D88ED9145FC8D92B3490@MW2PR12MB2556.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sp2q6I0/cMcZnlJBxzJg2NDR4QGBf6tq/N+mFBwpoG+yYw1O92AUI9VCG4zb9f1bR/jWSUuBJoxG0zjTxvcAlhF80CAY/U9K7GQLUU1zEd8uJMpUL/9DDzIjzy/YKRtupze5hGri9Se9LiS+AzAi6wEembR9bSX4GoC6pTm0lcKgexEHDR2JHLfJy9763XtBioCmR6qrB/S03mREGkCLkQ6ZFZblV77E7/+ITD/4F3H6KEbjUXCKbfGTBkWDXDEtBNfsN2l5nIFzaJJ254zI6JGYq0WYNk2atGW29W2W9asd6lCutfPlq2Mr8BBJ48UwOf7g9et46cbQ3Utbm0MtrSW5l0nyvbsQnShYXa1no/dfLAdwFx6HfwRGQ8m943Uc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4442.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(39830400003)(396003)(366004)(136003)(316002)(66556008)(66946007)(2906002)(956004)(66476007)(2616005)(1076003)(8936002)(8886007)(186003)(5660300002)(52116002)(83380400001)(8676002)(55016002)(7696005)(33656002)(36756003)(26005)(508600001)(16526019)(86362001)(27376004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: kp8VhXNbOpt/vPZ3/jImzxQEvGNE01J3g+jT0uGwBkI0Xf23nwbMG+Hz+wYxkp72w7uM/L/FuJ+EBWxPQga/wBD9JMxMFcEkEnwoXCXZ5fgeUrpYdkERJ+dW2kNuJu4hE4BHXdbc/i2h9jR/HP72LzB9lJXeoVj9AkEPs18O63CjBaZ5lTvX/wlYMn3J3CCl4PyHLrfZKR3EXYd7g24fFhWZ5Bz4JStxzDB8FUFIpRtWfdEx7lKS9VNXBjHwPAuBECLZUbHjObauDVVZDJZi8XiqK7etnGT/CALCMIjzcaS7Be3DYvCsTFwYmt3ar4DSeNPbEf66yPkV7AuxYLSO+ElM+ai4KU6b+jG1AgzkDSMGvEEJ6c8N9mRRCRYtnPsf5kBh5cJQ0qs8Ws2+9nG/230XiWZH3dD6bCx41vrSZHHjgOSQCfcJVP1JYAXt7AnfIJVh9f2dLTmgR6Bf6jJ7TypwJ9tIZx2nFjEVy38O4mI/ACcu+z6s8bXq/PnZccEIoLCjQ0s5Qitlr5iEkobC5nJ4PJtBaHcOjbZFJ+4fVOWfHAJlR7r9q42WSIUIyq5VLXhCj7E4lmul2Y1F3HpQlDbFaF8XvVmge0TEfZ2jAOOBVNzlocnuwQ56vR+oYdMyFbMt2GwzqKIAGj+LUFgfIg==
X-OriginatorOrg: optio3.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 991db99e-53b7-472e-994d-08d83a721749
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4442.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 01:34:56.7144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f356a620-3f2a-48a0-82be-05b0402c7634
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ioJ+iGM5vKEGBcjngpZcjHxPQVCXs90vPQx4bzmAZztdAEQhOfv/SqSkinEMdfqpFtW0rADPXt9J6MJJ5E499w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2556
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi there,

After the last refactoring, m_can_runtime_suspend()/resume() would call
the corresponding m_can_class_suspend() and m_can_class_resume() functions.
That caused a recursion through m_can_clk_start/stop calls, with a deadlock
due to spin_lock_irqsave(&dev->power.lock, flags).

The temporary solution, put in place in 0704c57,
was to remove the call to m_can_runtime_resume().

However, this breaks the driver on SoCs that use pinmux to control
the CAN controller. The controller would be permanently disconnected
from the outside world.

The fix for the recursion is to remove calls to m_can_clk_start/stop()
from resume/suspend, since m_can_clk_start/stop() calls are
what triggered resume/suspend.

Signed-off-by: Davide Massarenti <davide.m@optio3.com>
---
 drivers/net/can/m_can/m_can.c          | 7 -------
 drivers/net/can/m_can/m_can_platform.c | 3 +++
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 02c5795b7393..f801205fff78 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1866,7 +1866,6 @@ int m_can_class_suspend(struct device *dev)
 		netif_stop_queue(ndev);
 		netif_device_detach(ndev);
 		m_can_stop(ndev);
-		m_can_clk_stop(cdev);
 	}
 
 	pinctrl_pm_select_sleep_state(dev);
@@ -1887,12 +1886,6 @@ int m_can_class_resume(struct device *dev)
 	cdev->can.state = CAN_STATE_ERROR_ACTIVE;
 
 	if (netif_running(ndev)) {
-		int ret;
-
-		ret = m_can_clk_start(cdev);
-		if (ret)
-			return ret;
-
 		m_can_init_ram(cdev);
 		m_can_start(ndev);
 		netif_device_attach(ndev);
diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
index 38ea5e600fb8..51497410c4c1 100644
--- a/drivers/net/can/m_can/m_can_platform.c
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -166,6 +166,9 @@ static int __maybe_unused m_can_runtime_resume(struct device *dev)
 	if (err)
 		clk_disable_unprepare(mcan_class->hclk);
 
+	if (!err)
+		m_can_class_resume(dev);
+
 	return err;
 }
 
-- 
2.17.1

