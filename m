Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6EE03CB762
	for <lists+linux-can@lfdr.de>; Fri, 16 Jul 2021 14:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238357AbhGPMhi (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 16 Jul 2021 08:37:38 -0400
Received: from mail-eopbgr40111.outbound.protection.outlook.com ([40.107.4.111]:6916
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232787AbhGPMhh (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 16 Jul 2021 08:37:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cj/zreicD+fOkLE/AwXdIcUQb28Mv5RYKJub48v221vwmQpPP3n7aw8h19LMBaKL4V0MMV6Eq8bbUOwDn51EDuvFIYu0bncuCCNBQWElVLqeI1SS976XUWW3p2QlByU6aLWzJQmoebMkE9JTBgInhBvVmjGX285Bz9CO8oNJkRygd1zLkgJhQpjMrw5PJhlIEplKZJpGDuP7wfAqJc3eFxVF8/BaAZkwMz/i0EPGdxkRpbDaRhXD/jIoxLBlvZUfC5R0l+U1f4/pfZ8ud7APv7pqcs1cfOWszrI3M5xdoMyr2yPrLF1MikcC1pQ+681qoJ7hiX//OVlgrrsv8azGKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbJSMpzQyg42Ow+ZU3MbYkxzPVzhhkKXmywKHxrQ9BA=;
 b=nZYDR5cWv/zlGAJPq3xrQmLBN87AMc7q8zlzSE1uoms9aXtshsKshzkxVnu/oTQUehPAhtu/bEOVMoF3Av0oq0S3eHMqs7rHvaJS2Tr3A5RVrBXAYQAlFrskyAQAdhGDASiiD2UfA14UNURVgErZ+S/Lrn9Fo8+5PWhjqZm3m33QEX/+MhP2dBXco/4LswoG+TnLWmmmF4Y2LEr+4t96JovAsBsht8foBtuxY8wNSX2A22d+5hlnKTjU8aWHz9IL8/50pELeGodoSt4sV2nQBJdyTfYyUFjwt8WrcvA+ngyBBHOrVQ+v8wVyBi6wIHv+5OrGvM9tzjR3pN5yGVakOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 217.86.141.140) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=esd.eu;
 dmarc=none action=none header.from=esd.eu; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbJSMpzQyg42Ow+ZU3MbYkxzPVzhhkKXmywKHxrQ9BA=;
 b=VgACIxAoX2A6f9ItOXiENw2VVler6gKtcrfM411+I8tWrJMqGCEdPb9ztwnIIvi1HMtSOmp2cWCKkfw+AzKE1kyWJmx80tZe1LUO+XspVoflfi1AddlbZSac2+w6j8EI/CKJKIl6JnGFQkxJqvBhSK5z31E5AeQqiTwkZZ6T4OU=
Received: from AM6P191CA0063.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:7f::40)
 by AM0PR03MB4067.eurprd03.prod.outlook.com (2603:10a6:208:74::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Fri, 16 Jul
 2021 12:34:40 +0000
Received: from AM7EUR06FT014.eop-eur06.prod.protection.outlook.com
 (2603:10a6:209:7f:cafe::40) by AM6P191CA0063.outlook.office365.com
 (2603:10a6:209:7f::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Fri, 16 Jul 2021 12:34:40 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 217.86.141.140) smtp.mailfrom=esd.eu; pengutronix.de; dkim=none (message not
 signed) header.d=none;pengutronix.de; dmarc=none action=none
 header.from=esd.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning esd.eu
 discourages use of 217.86.141.140 as permitted sender)
Received: from esd-s7.esd (217.86.141.140) by
 AM7EUR06FT014.mail.protection.outlook.com (10.233.255.192) with Microsoft
 SMTP Server id 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021
 12:34:40 +0000
Received: from esd-s9.esd.local (unknown [10.0.0.190])
        by esd-s7.esd (Postfix) with ESMTP id B2F067C1635;
        Fri, 16 Jul 2021 14:34:37 +0200 (CEST)
Received: by esd-s9.esd.local (Postfix, from userid 2044)
        id 97377E00E4; Fri, 16 Jul 2021 14:34:37 +0200 (CEST)
From:   =?UTF-8?q?Stefan=20M=C3=A4tje?= <Stefan.Maetje@esd.eu>
To:     mkl@pengutronix.de
Cc:     o.rempel@pengutronix.de, linux-can@vger.kernel.org
Subject: [PATCH 0/1] Propose patch to fix build failure on net/can/j1919/transport.c
Date:   Fri, 16 Jul 2021 14:34:36 +0200
Message-Id: <20210716123437.20825-1-Stefan.Maetje@esd.eu>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7e81542-36fb-4c20-0a4d-08d9485614f6
X-MS-TrafficTypeDiagnostic: AM0PR03MB4067:
X-Microsoft-Antispam-PRVS: <AM0PR03MB4067D071D92114FF04731F6481119@AM0PR03MB4067.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EI9jttN0QnRIF6rCLR4sQPHSYyGNwoq5iQ+ZVXPZ4qcV12UI9cguZBO5taovOZMflqBLujYPUqLFuuuUAqv1QPM3ze4YvpmocrJ8GlKqlzU92nMLTz+hzXLzCf7mI/iFwPJjY5zjHAu1/ygCBrmlR/Z/ohc8tNja8e1VHcKSXW9uVLc6Sp3Xxy+2AzgC+OGFhDW7b+gVB9lWYEXyWFEbUPFemjyfbmlCHymKrUSZSrWYPfV+sX+kdCgdaHyR7eKcbWqF61Yir0zvYyqC88SnuZ2pOtqgs/2VT6kjNXeI3ie+cLk49hnbYzrAoKuihSxnt9uBA+MdLs5596A1dl3TdqtG9lRamAN2DwLYf8YVYZVlnz0E6LU//UiDz+eaOVercFqlKlNnLZWe4BtBJMrTV/hHnNPeVwb3b8m0RnLkmJVlFaBksQzivMMHtwQfToJLBh7P0+8nW6xYJr6mxp0VYXW0sYcS8oOKNIkwWcVGTmvZa1xuQg6ynPjxQ9ZvuSD3CqdtxkBXghsIUHubrd9QAI42clwkXpEMtR7CCGpdKc3iH/nzR2sULae2Lx1gDMpEayrKlsWOIvrryYc57dOYS2mtXuJOsl2tnzTBdn/xVzLvgBGqQSfmSAyDq6KwNEtJsWOBMCnc/FKcfbRb0D86qXiptd0eqSQIngNnp9IIloqKEQv0sl4JVDfIsJ9v5ROrWUeoBUqTIqPm8YzCPL3Naw==
X-Forefront-Antispam-Report: CIP:217.86.141.140;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:esd-s7.esd;PTR:pd9568d8c.dip0.t-ipconnect.de;CAT:NONE;SFS:(136003)(396003)(346002)(376002)(39830400003)(46966006)(36840700001)(8936002)(336012)(81166007)(42186006)(82310400003)(316002)(2616005)(36756003)(356005)(83380400001)(4326008)(26005)(36860700001)(70586007)(6916009)(4744005)(86362001)(66574015)(47076005)(2906002)(8676002)(5660300002)(70206006)(186003)(1076003)(478600001)(6266002);DIR:OUT;SFP:1102;
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 12:34:40.4702
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7e81542-36fb-4c20-0a4d-08d9485614f6
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b;Ip=[217.86.141.140];Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR06FT014.eop-eur06.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB4067
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Marc,

during my last kernel build from linux-can-next branch testing I encountered
a build failure. It seems to be related by one of your patches for J1939.

The attached patch fixes the build failure for me but as I don't know anything
about J1939 it may be wrong.

Best regards,
    Stefan Mätje

Stefan Mätje (1):
  can: j1939: j1939_session_tx_dat(): Fix build failure introduced by
    renaming skcb to se_skcb

 net/can/j1939/transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.25.1

