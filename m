Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02118729CB6
	for <lists+linux-can@lfdr.de>; Fri,  9 Jun 2023 16:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238484AbjFIOYd (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 9 Jun 2023 10:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjFIOYb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 9 Jun 2023 10:24:31 -0400
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDA330E7
        for <linux-can@vger.kernel.org>; Fri,  9 Jun 2023 07:24:28 -0700 (PDT)
Received: from 104.47.7.172_.trendmicro.com (unknown [172.21.178.36])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id A882010002180;
        Fri,  9 Jun 2023 14:24:26 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1686320664.263000
X-TM-MAIL-UUID: 865d1333-f456-4474-ba73-58bd7f46b711
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.172])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 4081010000FF8;
        Fri,  9 Jun 2023 14:24:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CcWqGkHUwx96v8vv7WM8BgDhxFfYrCDYC8QjyqVTuYTYdvZpbWRWn5Sak9XZuwvkhSNClwBKQjhgNg8narU3TZhREAyFkbmoSgKme1+Atk/LipdZQEe627k6L9Mj2rj05ytHQm9+uR+hF9FHnLAKeMlUJiWq567NqERTUFT7SeSV6dSpjQnkjfUKfnNWTEEO5ts9mIuFr0H+67qeseKeflC8TImCHB24VoVMJTLWsENm03l1EjeAWpZD7840dcf8lPTsXXSc396+guiQljsprfuWKsllFO+0zUTtiV/ag865j+IpMZ7sWO2NqgX/CvsuWXY0Q/WA6JvDMOxt/QDECA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d76kvn/AOMyIz4yf10f3PfBOVKFT1NVhPpTJbe87ptU=;
 b=cjWl1hqr50VHcwhCZJ5wb+wjP49dx0hd+avD24+hEXAfYUjYqUzXrdZdKidBOJpKJ03efOJSsEy0oiAMeJgJ9qEI7fTlNzgH+uAg0qtSRWHiTOUxoOVliqM+726ef2VBwbXpw7ZFosj4rnhImlFS3b9CYArUe4lFLuN86dIh392Wy5CkNXA083GSF3ogSsvVbsXJCknrj0TAwFLnlYZ2AdPWfhXUuiMxC20BvO5SgieXwdETn+5Io11g/V52xFk3NZ6rLkf+2YpQ/FqznX49RtYl28wmJ9geBi5ZbdQwDA7VwJN61pPMRivrmWW7YuvRm2MDiJe7m60iT2FDojyiJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 217.66.60.4) smtp.rcpttodomain=lists.oasis-open.org
 smtp.mailfrom=opensynergy.com; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=opensynergy.com; dkim=none (message not
 signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.66.60.4)
 smtp.mailfrom=opensynergy.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=opensynergy.com;
Received-SPF: Pass (protection.outlook.com: domain of opensynergy.com
 designates 217.66.60.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.66.60.4; helo=SR-MAIL-03.open-synergy.com; pr=C
From:   Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>
To:     virtio-comment@lists.oasis-open.org,
        virtio-dev@lists.oasis-open.org, linux-can@vger.kernel.org
Cc:     Harald Mommer <harald.mommer@opensynergy.com>,
        Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>
Subject: [RFC PATCH v3] virtio-can: Device specification.
Date:   Fri,  9 Jun 2023 16:22:43 +0200
Message-Id: <20230609142243.199074-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8EUR05FT037:EE_|FR0P281MB2956:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a6f0e511-aaa8-4825-b2f0-08db68f53852
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mvshnqFKXLZGM6XSbo1pvYXG/BCUj0H6aDl+98bM1c3WcpU2K3DQhxV7kc+SIdQOLlpeUaTM4Xi5uoBlzdnE0bD21RW9F6QGtpyp35MX8pvnfPGuZr/jQC3pL2N6JCBWdK985nZ/KmFliluP1PXuWInXyQe/ZEIg/f8Shu4K9XLmUuEGhrbl5x9F+RwkjC6xW5d1nShw5l9kXzhKJqBZWjuZpR8I7NgniRb9koRrT0/ocdRmphLagX1Bl0u++cS0tKKNbb9R1ohmN4PVydellxkQ9satr0MVJ1xZuC1zUUxRGGwq4+L4/b4oViCxehjrpZVZnuJ2RimDRXREYjt+Gyg5n4BRIAWXrEQwkS1+dWXCHZnhWT1suze1i/H8EP2OWVSQpLOwduJbAze6aozjq8fkO02IexfesopHxu8PfC8/bdFQk41CZ++QHrOWPx8lBi7MQcnWJrzQKvz1pe6OmrJ/pSJF06m79pumE/7J7plW7ZDb4gIkHnt24U3m0UakMqnQbhFijp6/YVFoJSJkO+g5HFXyaAQEGM2ip8KMqVL/iE5tHxVi4gSMQibUfb1umuk+esQDA0OV5ihLcyqxQFfY+e/08r6Uk/OYT/tdDrigwZP0MDWZ3VVFFZYiUGO9TytfDsu1rRKmjj23U/XJW6fe5qjN0mX1mrTo4OUpyjj/PrZF+5OSiHVCdEOvfVFmALjsBEUWM9M0RMONS4I4Bq4bKXAvNH2keG9FSY79C0xLYyHq0WTePh2N3K0lv1O74quReji+5UxrcYqRsPejgg==
X-Forefront-Antispam-Report: CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(39830400003)(136003)(346002)(376002)(396003)(451199021)(36840700001)(46966006)(40480700001)(54906003)(42186006)(81166007)(478600001)(8936002)(8676002)(4326008)(316002)(70206006)(41300700001)(70586007)(336012)(186003)(36860700001)(47076005)(966005)(83380400001)(1076003)(26005)(107886003)(2906002)(82310400005)(5660300002)(86362001)(30864003)(2616005)(36756003)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 14:24:22.3183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6f0e511-aaa8-4825-b2f0-08db68f53852
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource: DB8EUR05FT037.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB2956
X-TM-AS-ERS: 104.47.7.172-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1007-27682.000
X-TMASE-Result: 10--26.124600-4.000000
X-TMASE-MatchedRID: FQo/JhuHF00ZHQl0dvECsXAqViM7NdjVW+HVwTKSJIY6RMUrbW0uJ1Lt
        xulXGyZGYBmLADQcJWErnYD0sOkV/+qkGyCVA3KtEhGH3CRdKUUm/w9lcQc8oRHfiujuTbedLXk
        gVQ0v4RNNzkYkwdUqPwTBk00Umo7CoDlDgS6jzLS5x7uAXGEprT/FEHo4advawLkNMQzGl5B+Kr
        WCPbERP4+pAn19BHXOfRebBeurGSV1qnwsUimTHK5bb5QEYSkdX098A7fr3VdYC5LPd7BvbdPQ+
        kcNsyKzNscteyNb+fhRevyDj8WHOaGFWO1mOgdPRZfQN+FVqbBSJwEFeNPAEUyi1T9AUgUbF59H
        7gVl/t38j7J3SZxjRaujTqkPXABXFzf70NhciTsZca7SN08UZJQ7eT0DII9N/gMNehoKqTutxFy
        0luQUIQqiJVMMD4HsOO0vU+Ua+tntAxjyNphE0gvBTB90+he+WQ3R4k5PTnDRnp8Qx+pp63V12A
        gUmT2WQHRQTwWPkIyDq5ivJOU/MoWAdP+2VqSZQ+B060dtsCPJ5SXtoJPLyFKXVaiCgOJykGbdF
        0gLF1A5DMj/FS1NXB6LHQQSul7ZSMz6Ix5mZ6rece0aRiX9WjsKvZyemuhsPZN54nI8dExiY4PR
        l594rRiRwJfEYHFwCrkqK+JFJ5TiaPUT+aN6kmSIsH2qgnAf6rTgjAjMzmHpna82kii/XKPFjJE
        Fr+ol4wnhOb+JR+RwYOfITr148d5JXB8gNxDE3QfwsVk0UbslCGssfkpInQ==
X-TMASE-XGENCLOUD: 08160c2a-ba0c-492c-bd34-4fff53168d00-0-0-200-0
X-TM-Deliver-Signature: DAFC6F93F5AF73E9C6C6E8D0F70FEA3B
X-TM-Addin-Auth: sxcptmYX6B1cSmbcrRHSdVc6p8SQIe+dDtDorPKuj5K2x6GMBqRbzkh2Nby
        co1B2m1tXrjFGDCIzKErJssuvhS3b74wbJvibx3tdK5EDYVz9qUnICRO3zUVcuh7a0dFeUBL6yD
        IjI9IAtxKez9Qwl6M7pj9Qiwti8kmXxQG6YIyvzScmAR+S36FsXkpwuVYigSth5ITcdHR/Gsj0M
        3dzVfD0ugbdCQaVkP6XPWT7e+GxYY+fl7mf3uJb/aqkIkHB57xnH/uhJDSSmFdsrFWAlfQHzAfM
        35Udls2OqF0wMtCC5EvjHrbP5m5LKrKoYgmf.RUKE06NbjyZaBpXsUgcJYovy2qIFitxhZ/4rgO
        ibDzUqZmxMiSRQ9+hsQ4XAqxiC3bTMslOUTq8xjB7fkCFsxR66hEXRPP9paxBZIxK4IbMROo5a1
        BDZPhFmXk5ZLp/BHHDyP/szqRvpc+RvKQa1vn5h+YIKx0n5fEIiboRDvCghGXqvNA5PFMpaSLfx
        urUTUEGvbs0Ou2Bc1N5RGI2m0ui6P05sJm4gIrlyhFIBjIoe3xORJRyy6thV0WMoT/iyxxXd4ER
        L1Nnp/ix2D0K2aJqp460Xff49kEKlc1BMzIIO5YhVd8VeL0TXYBZHKhyxSLtYQ4jzZAc/SxztDt
        onzA==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1686320666;
        bh=Y5J7dlQOnctjw8sYWEVUgETn9my56C27SBJcf4H4D/Q=; l=16965;
        h=From:To:Date;
        b=Twy5F27WjPHwFcpE9dCat9mcib82M9e8Z7KrUYT1nSm9zZN1U1mgpu6axUmbY/cg/
         yQH/l9JmKbw6b31+qd60nrEacNHhg5WhbVq/z4HLhRNyRTFw2+9iWjj2+TbyZV5bgR
         axh0ijukvXbBIUFvTUzW2pAVR1awVvWJoam751QO8N+DJBd9Y86j3JBd/6L1WchUTO
         pOlXws2OHF2h+meY/g0K26bY0O14nLmIqh8z3dvk9UhYCOfzWyVlIEvKURDUx6u8Xn
         utxeumAklTBf1RkN5HTcG0R0h7/i8fiw/EgoorJb+tfAGs9cky0rOaezIS0XzYpnbc
         ajVwkQdNbWMvg==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Harald Mommer <harald.mommer@opensynergy.com>

virtio-can is a virtual CAN device. It provides a way to give access to
a CAN controller from a driver guest. The device is aimed to be used by
driver guests running a HLOS as well as by driver guests running a
typical RTOS as used in controller environments.

Signed-off-by: Harald Mommer <Harald.Mommer@opensynergy.com>
Signed-off-by: Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>
---

RFC v3:
* Add length fields in CAN RX and TX messages.
* Replace bus off indication queue with a config space bit.
* Clarify handling of unknown flag bits set in CAN frame.
* Remove MISRA C suffixes in constants.
* Reserve 16 bits in RX/TX messages for CAN XL priority.
* Reserve 8 bits in RX/TX messages for CAN classic DLC.
* Rework according to general virtio spec POV.
* Implementation:
  driver: https://lore.kernel.org/all/20230607145613.133203-1-Mikhail.Golubev-Ciuchea@opensynergy.com/
  QEmu device: https://github.com/OpenSynergy/qemu/tree/virtio-can-spec-rfc-v3

RFC v2:
* Add CAN classic feature flag.
* Add feature flag VIRTIO_CAN_F_LATE_TX_ACK.
* Add feature flag VIRTIO_CAN_F_RTR_FRAMES.
* Reserve 32 bits in RX/TX messages.
* Remove priorities of messages. 

 conformance.tex                         |  12 +-
 content.tex                             |   1 +
 device-types/can/description.tex        | 249 ++++++++++++++++++++++++
 device-types/can/device-conformance.tex |   8 +
 device-types/can/driver-conformance.tex |   7 +
 introduction.tex                        |   2 +
 6 files changed, 275 insertions(+), 4 deletions(-)
 create mode 100644 device-types/can/description.tex
 create mode 100644 device-types/can/device-conformance.tex
 create mode 100644 device-types/can/driver-conformance.tex

diff --git a/conformance.tex b/conformance.tex
index 01ccd69..a07ef02 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -32,8 +32,9 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \ref{sec:Conformance / Driver Conformance / Memory Driver Conformance},
 \ref{sec:Conformance / Driver Conformance / I2C Adapter Driver Conformance},
 \ref{sec:Conformance / Driver Conformance / SCMI Driver Conformance},
-\ref{sec:Conformance / Driver Conformance / GPIO Driver Conformance} or
-\ref{sec:Conformance / Driver Conformance / PMEM Driver Conformance}.
+\ref{sec:Conformance / Driver Conformance / GPIO Driver Conformance},
+\ref{sec:Conformance / Driver Conformance / PMEM Driver Conformance} or
+\ref{sec:Conformance / Driver Conformance / CAN Driver Conformance}.
 
     \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
   \end{itemize}
@@ -59,8 +60,9 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \ref{sec:Conformance / Device Conformance / Memory Device Conformance},
 \ref{sec:Conformance / Device Conformance / I2C Adapter Device Conformance},
 \ref{sec:Conformance / Device Conformance / SCMI Device Conformance},
-\ref{sec:Conformance / Device Conformance / GPIO Device Conformance} or
-\ref{sec:Conformance / Device Conformance / PMEM Device Conformance}.
+\ref{sec:Conformance / Device Conformance / GPIO Device Conformance},
+\ref{sec:Conformance / Device Conformance / PMEM Device Conformance} or
+\ref{sec:Conformance / Device Conformance / CAN Device Conformance}.
 
     \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
   \end{itemize}
@@ -152,6 +154,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \input{device-types/scmi/driver-conformance.tex}
 \input{device-types/gpio/driver-conformance.tex}
 \input{device-types/pmem/driver-conformance.tex}
+\input{device-types/can/driver-conformance.tex}
 
 \conformance{\section}{Device Conformance}\label{sec:Conformance / Device Conformance}
 
@@ -238,6 +241,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \input{device-types/scmi/device-conformance.tex}
 \input{device-types/gpio/device-conformance.tex}
 \input{device-types/pmem/device-conformance.tex}
+\input{device-types/can/device-conformance.tex}
 
 \conformance{\section}{Legacy Interface: Transitional Device and Transitional Driver Conformance}\label{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}
 A conformant implementation MUST be either transitional or
diff --git a/content.tex b/content.tex
index d2ab9eb..8806b57 100644
--- a/content.tex
+++ b/content.tex
@@ -765,6 +765,7 @@ \chapter{Device Types}\label{sec:Device Types}
 \input{device-types/scmi/description.tex}
 \input{device-types/gpio/description.tex}
 \input{device-types/pmem/description.tex}
+\input{device-types/can/description.tex}
 
 \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
 
diff --git a/device-types/can/description.tex b/device-types/can/description.tex
new file mode 100644
index 0000000..2511d9c
--- /dev/null
+++ b/device-types/can/description.tex
@@ -0,0 +1,249 @@
+\section{CAN Device}\label{sec:Device Types / CAN Device}
+
+virtio-can is a virtio based CAN (Controller Area Network) controller.
+It is used to give a virtual machine access to a CAN bus. The CAN bus
+might either be a physical CAN bus or a virtual CAN bus between virtual
+machines or a combination of both.
+
+\subsection{Device ID}\label{sec:Device Types / CAN Device / Device ID}
+
+36
+
+\subsection{Virtqueues}\label{sec:Device Types / CAN Device / Virtqueues}
+
+\begin{description}
+\item[0] Txq
+\item[1] Rxq
+\item[2] Controlq
+\end{description}
+
+The \field{Txq} is used to send CAN packets to the CAN bus.
+
+The \field{Rxq} is used to receive CAN packets from the CAN bus.
+
+The \field{Controlq} is used to control the state of the CAN controller.
+
+\subsection{Feature bits}{Device Types / CAN Device / Feature bits}
+
+Actual CAN controllers support Extended CAN IDs with 29 bits (CAN~2.0B)
+as well as Standard CAN IDs with 11 bits (CAN~2.0A). The support of
+CAN~2.0B Extended CAN IDs is considered as mandatory for this
+specification.
+
+\begin{description}
+
+\item[VIRTIO_CAN_F_CAN_CLASSIC (0)]
+
+The device supports classic CAN frames with a maximum payload size of 8
+bytes.
+
+\item[VIRTIO_CAN_F_CAN_FD (1)]
+
+The device supports CAN FD frames with a maximum payload size of 64
+bytes.
+
+\item[VIRTIO_CAN_F_RTR_FRAMES (2)]
+
+The device supports RTR (remote transmission request) frames. RTR frames
+are only supported with classic CAN.
+
+\item[VIRTIO_CAN_F_LATE_TX_ACK (3)]
+
+The virtio CAN device marks transmission requests from the \field{Txq}
+as used after the CAN message has been transmitted on the CAN bus. If
+this feature bit has not been negotiated, the device is allowed to mark
+transmission requests already as used when the CAN message has been
+scheduled for transmission but might not yet have been transmitted on
+the CAN bus.
+
+\end{description}
+
+\subsubsection{Feature bit requirements}\label{sec:Device Types / CAN Device / Feature bits / Feature bit requirements}
+
+Some CAN feature bits require other CAN feature bits:
+\begin{description}
+\item[VIRTIO_CAN_F_RTR_FRAMES] Requires VIRTIO_CAN_F_CAN_CLASSIC.
+\end{description}
+
+It is required that at least one of VIRTIO_CAN_F_CAN_CLASSIC and
+VIRTIO_CAN_F_CAN_FD is negotiated.
+
+\subsection{Device configuration layout}\label{sec:Device Types / CAN Device / Device configuration layout} 
+
+Device configuration fields are listed below, they are read-only for a
+driver. The \field{status} always exists. A single read-only bit (for
+the driver) is currently defined for \field{status}:
+
+\begin{lstlisting}
+struct virtio_can_config {
+#define VIRTIO_CAN_S_CTRL_BUSOFF (1 << 0)
+        le16 status;
+};
+\end{lstlisting}
+
+The bit VIRTIO_CAN_S_CTRL_BUSOFF in \field{status} is used to indicate
+the unsolicited CAN controller state change from started to stopped due
+to a detected bus off condition.
+
+\drivernormative{\subsubsection}{Device Initialization}{Device Types / CAN Device / Device Operation / Initialization}
+
+The driver MUST populate the \field{Rxq} with empty device-writeable
+buffers of at least the size of struct virtio_can_rx, see section
+\ref{struct virtio_can_rx}.
+
+\subsection{Device Operation}\label{sec:Device Types / CAN Device / Device Operation}
+
+A device operation has an outcome which is described by one of the
+following values:
+
+\begin{lstlisting}
+#define VIRTIO_CAN_RESULT_OK     0
+#define VIRTIO_CAN_RESULT_NOT_OK 1
+\end{lstlisting}
+
+Other values are to be treated like VIRTIO_CAN_RESULT_NOT_OK.
+
+\subsubsection{Controller Mode}\label{sec:Device Types / CAN Device / Device Operation / Controller Mode}
+
+The general format of a request in the \field{Controlq} is
+
+\begin{lstlisting}
+struct virtio_can_control_out {
+#define VIRTIO_CAN_SET_CTRL_MODE_START  0x0201
+#define VIRTIO_CAN_SET_CTRL_MODE_STOP   0x0202
+        le16 msg_type; 
+};
+\end{lstlisting}
+
+To participate in bus communication the CAN controller is started by
+sending a VIRTIO_CAN_SET_CTRL_MODE_START control message, to stop
+participating in bus communication it is stopped by sending a
+VIRTIO_CAN_SET_CTRL_MODE_STOP control message. Both requests are
+confirmed by the result of the operation.
+
+\begin{lstlisting}
+struct virtio_can_control_in {
+        u8 result;
+};
+\end{lstlisting}
+
+If the transition succeeded the \field{result} is VIRTIO_CAN_RESULT_OK
+otherwise it is VIRTIO_CAN_RESULT_NOT_OK. If a status update is
+necessary, the device updates the configuration \field{status} before
+marking the request used. As the configuration \field{status} change is
+caused by a request from the driver the device is allowed to omit the
+configuration change notification here. The device marks the request
+used when the CAN controller has finalized the transition to the
+requested controller mode.
+
+On transition to the STOPPED state the device cancels all CAN messages
+already pending for transmission and marks them as used with
+\field{result} VIRTIO_CAN_RESULT_NOT_OK. In the STOPPED state the
+device marks messages received from the
+\field{Txq} as used with \field{result} VIRTIO_CAN_RESULT_NOT_OK without
+transmitting them to the CAN bus.
+
+Initially the CAN controller is in the STOPPED state.
+
+Control queue messages are processed in order.
+
+\devicenormative{\subsubsection}{CAN Message Transmission}{Device Types / CAN Device / Device Operation / CAN Message Transmission}
+
+The driver transmits messages by placing outgoing CAN messages in the
+\field{Txq} virtqueue.
+
+\label{struct virtio_can_tx_out}
+\begin{lstlisting}
+struct virtio_can_tx_out {
+#define VIRTIO_CAN_TX 0x0001
+        le16 msg_type;
+        le16 length; /* 0..8 CC, 0..64 CAN-FD, 0..2048 CAN-XL, 12 bits */
+        u8 reserved_classic_dlc; /* If CAN classic length = 8 then DLC can be 8..15 */
+        u8 padding;
+        le16 reserved_xl_priority; /* May be needed for CAN XL priority */
+#define VIRTIO_CAN_FLAGS_FD            0x4000
+#define VIRTIO_CAN_FLAGS_EXTENDED      0x8000
+#define VIRTIO_CAN_FLAGS_RTR           0x2000
+        le32 flags;
+        le32 can_id;
+        u8 sdu[];
+};
+
+struct virtio_can_tx_in {
+        u8 result;
+};
+\end{lstlisting}
+
+The length of the \field{sdu} is determined by the \field{length}.
+
+The type of a CAN message identifier is determined by \field{flags}. The
+3 most significant bits of \field{can_id} do not bear the information
+about the type of the CAN message identifier and are 0.
+
+The device MUST reject any CAN frame type for which support has not been
+negotiated with VIRTIO_CAN_RESULT_NOT_OK in \field{result} and MUST NOT
+schedule the message for transmission. A CAN frame with an undefined bit
+set in \field{flags} is treated like a CAN frame for which support has
+not been negotiated.
+
+The device MUST reject any CAN frame for which \field{can_id} or
+\field{sdu} length are out of range or the CAN controller is in an
+invalid state with VIRTIO_CAN_RESULT_NOT_OK in \field{result} and MUST
+NOT schedule the message for transmission.
+
+If the parameters are valid the message is scheduled for transmission.
+
+If feature VIRTIO_CAN_F_CAN_LATE_TX_ACK has been negotiated the
+transmission request MUST be marked as used with \field{result} set to
+VIRTIO_CAN_OK after the CAN controller acknowledged the successful
+transmission on the CAN bus. If this feature bit has not been negotiated
+the transmission request MAY already be marked as used with
+\field{result} set to VIRTIO_CAN_OK when the transmission request has
+been processed by the virtio CAN device and send down the protocol stack
+being scheduled for transmission.
+
+\subsubsection{CAN Message Reception}\label{sec:Device Types / CAN Device / Device Operation / CAN Message Reception}
+
+Messages can be received by providing empty incoming buffers to the
+virtqueue \field{Rxq}.
+
+\label{struct virtio_can_rx}
+\begin{lstlisting}
+struct virtio_can_rx {
+#define VIRTIO_CAN_RX 0x0101
+        le16 msg_type;
+        le16 length; /* 0..8 CC, 0..64 CAN-FD, 0..2048 CAN-XL, 12 bits */
+        u8 reserved_classic_dlc; /* If CAN classic length = 8 then DLC can be 8..15 */
+        u8 padding;
+        le16 reserved_xl_priority; /* May be needed for CAN XL priority */
+        le32 flags;
+        le32 can_id;
+        u8 sdu[];
+};
+\end{lstlisting}
+
+If the feature VIRTIO_CAN_F_CAN_FD has been negotiated the maximal
+possible \field{sdu} length is 64, if the feature has not been
+negotiated the maximal possible \field{sdu} length is 8.
+
+The actual length of the \field{sdu} is determined by the \field{length}.
+
+The type of a CAN message identifier is determined by \field{flags} in
+the same way as for transmitted CAN messages, see section \ref{struct
+virtio_can_tx_out}. The 3 most significant bits of \field{can_id} do not
+bear the information about the type of the CAN message identifier and
+are 0. The flag bits are exactly the same as for the \field{flags} of
+struct virtio_can_tx_out.
+
+\subsubsection{BusOff Indication}\label{sec:Device Types / CAN Device / Device Operation / BusOff Indication}
+
+There are certain error conditions so that the physical CAN controller
+has to stop participating in CAN communication on the bus. If such an
+error condition occurs the device informs the driver about the
+unsolicited CAN controller state change by setting the
+VIRTIO_CAN_S_CTRL_BUSOFF bit in the configuration \field{status} field.
+
+After bus-off detection the CAN controller is in STOPPED state. The CAN
+controller does not participate in bus communication any more so all CAN
+messages pending for transmission are put into the used queue with
+\field{result} VIRTIO_CAN_RESULT_NOT_OK.
diff --git a/device-types/can/device-conformance.tex b/device-types/can/device-conformance.tex
new file mode 100644
index 0000000..f944ffd
--- /dev/null
+++ b/device-types/can/device-conformance.tex
@@ -0,0 +1,8 @@
+\conformance{\subsection}{CAN Device Conformance}\label{sec:Conformance / Device Conformance / CAN Device Conformance}
+
+A CAN device MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{devicenormative:Device Types / CAN Device / Feature bits}
+\item \ref{devicenormative:Device Types / CAN Device / Device Operation / CAN Message Transmission}
+\end{itemize}
diff --git a/device-types/can/driver-conformance.tex b/device-types/can/driver-conformance.tex
new file mode 100644
index 0000000..32e3e87
--- /dev/null
+++ b/device-types/can/driver-conformance.tex
@@ -0,0 +1,7 @@
+\conformance{\subsection}{CAN Driver Conformance}\label{sec:Conformance / Driver Conformance / CAN Driver Conformance}
+
+A CAN driver MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{drivernormative:Device Types / CAN Device / Device Operation / Initialization}
+\end{itemize}
diff --git a/introduction.tex b/introduction.tex
index b7155bf..d560c63 100644
--- a/introduction.tex
+++ b/introduction.tex
@@ -101,6 +101,8 @@ \section{Normative References}\label{sec:Normative References}
 	\phantomsection\label{intro:SEC1}\textbf{[SEC1]} &
     Standards for Efficient Cryptography Group(SECG), ``SEC1: Elliptic Cureve Cryptography'', Version 1.0, September 2000.
 	\newline\url{https://www.secg.org/sec1-v2.pdf}\\
+	\phantomsection\label{intro:CAN}\textbf{[CAN]} &
+    ISO 11898-1:2015 Road vehicles -- Controller area network (CAN) -- Part 1: Data link layer and physical signalling\\
 
 \end{longtable}
 
-- 
2.34.1

