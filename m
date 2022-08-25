Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4E15A1282
	for <lists+linux-can@lfdr.de>; Thu, 25 Aug 2022 15:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241859AbiHYNlM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 25 Aug 2022 09:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241679AbiHYNlK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 25 Aug 2022 09:41:10 -0400
X-Greylist: delayed 395 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 25 Aug 2022 06:41:05 PDT
Received: from refb02.tmes.trendmicro.eu (refb02.tmes.trendmicro.eu [18.185.115.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B162A3D45
        for <linux-can@vger.kernel.org>; Thu, 25 Aug 2022 06:41:04 -0700 (PDT)
Received: from 104.47.17.168_.trendmicro.com (unknown [172.21.19.113])
        by refb02.tmes.trendmicro.eu (Postfix) with ESMTPS id B7B52103B3811
        for <linux-can@vger.kernel.org>; Thu, 25 Aug 2022 13:34:29 +0000 (UTC)
Received: from 104.47.17.168_.trendmicro.com (unknown [172.21.188.236])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id B219B100017CB;
        Thu, 25 Aug 2022 13:34:27 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1661434467.001000
X-TM-MAIL-UUID: 50c0a1bb-80dc-43d4-a2c9-cb7e029f4403
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (unknown [104.47.17.168])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 00528100019D4;
        Thu, 25 Aug 2022 13:34:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W614tSzf9qKtLIxso3NaWf+1cMeNJaGNE/WKWeDFkuTa1bCZsJ3GVgWrmzT0Q+cRtakq1AmA0zEK1TvEliJ+/tAMrhEzBUrrC86tJ+7M35Wd54AEn5Tu1eD0OrsJj/CkNM2jEb61CvFcScTz1K+mzVO/HklaZ7cZMTte1TU7QnqFD7cF5oCoiZDINTmw2gqO3d1hHjFU5yDKrZS8vH3LisYaaaP2zfYgVAnAK6xKSygMYzg0SBWirUOfOYXVlV5+/3TcTPk9atE3NjaGAP4jT6QEvyLNbvtG7vjxCqVzo+WogNc2vgu+294BikSD3/WlkNiCb+fUgvq7s3D1bfbrNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqHrVKuZN6naTaFU32wE0YaCGYtSlpK2eg6T85OXbmM=;
 b=R7+Wvsyzz1pDueIcURRtwCc/bpyFKcD8l2mJ/6gGr6TP/FSv14SU00gJQ7pTxe9aX1yoNgJ8F5aWlhx43f5sSEPDmHEYvsZzaA1Og1q3KB7yJhB20NCS51SOYHoaXVooRKp1QJZqI9z1AWNKGkWSRec3tT0hJXiYlltrdrhHhORx/eMM3xHLnC8k1zTn4bHVmXjiXreV20H3Gw8W1oqn3BfznPTDm6J8xnWwI63X5gmOesp5Ts4o6wFo83EUUN4Kx8qf1c9n9OUSct6SogyovGhHyBvii78mtsuPXJsKr4miHQeDvrSGx0slXzgVbPqsRJdvpWuZ70eML8RsSdynqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 217.66.60.4) smtp.rcpttodomain=lists.oasis-open.org
 smtp.mailfrom=opensynergy.com; dmarc=pass (p=none sp=none pct=100)
 action=none header.from=opensynergy.com; dkim=none (message not signed);
 arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.66.60.4)
 smtp.mailfrom=opensynergy.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=opensynergy.com;
Received-SPF: Pass (protection.outlook.com: domain of opensynergy.com
 designates 217.66.60.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.66.60.4; helo=SR-MAIL-03.open-synergy.com; pr=C
From:   Harald Mommer <harald.mommer@opensynergy.com>
To:     virtio-comment@lists.oasis-open.org,
        virtio-dev@lists.oasis-open.org, linux-can@vger.kernel.org
Cc:     Dariusz Stojaczyk <Dariusz.Stojaczyk@opensynergy.com>,
        Harald Mommer <harald.mommer@opensynergy.com>
Subject: [RFC PATCH v2 1/1] virtio-can: Device specification - 2nd RFC draft.
Date:   Thu, 25 Aug 2022 15:34:10 +0200
Message-Id: <20220825133410.18367-1-harald.mommer@opensynergy.com>
X-Mailer: git-send-email 2.17.1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9cfc0c0e-0e40-42ca-50b6-08da869e869c
X-MS-TrafficTypeDiagnostic: AM7PR04MB7112:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HGVg+1n48bmuB19DG87OhJCrAMMD9tH2ffbteig3wbAET7t0f74JJ21tsDoN8s5AqZDHLnqph31i/oKLb24JRZDDvzFyyOjBxz9osirJuOIZgILqMEyRz6qEwhXY8IuQFTRs6r07Fcm9zDhRyjdpacIuz/9oxFe7zd8ZsosYyNauPvDfvbUglVUF7uF1KFSP+z13zjKrQtlbR46onWZDdKTWRm1Q7jKUDCVn23GVc4r8el0pcKOcGZSyG7gj3jdmWgh20/GkyVS1deYJoySTQwbfcQL07FvEvsywaYWaF+5yQR1J0pkMvMoBqmhgTnWbsx4SDTDc/r7h66t45wwExpT2LVIkF8SJ763b7joflfgcRFsSac7H8sCiJ9WmtvmK7S5MWzxToZ/A14quWngA2yHQLqjxUXpB7rIna7s1Uo9L3TnUoq16oGAs/bG4DXkWHHmqEvb2S2xlPl4jmGb/X8ioD6mn8pW24Ldu1C3lYny18TEveEqBS6u90OQ1Lpgm+IvPPuQi4Zz2VqxHH5JifDRa472CVrAui+ZB3kpQtG4YeZuqMb5QF7+RJGpvtTolmosVaKm6h53xeq91fVDXMUxLIIy34yMzC6ngmPEVN1FWKFmbv/kAkbnWp+zJRFzO+9oEHAn/MfN3AaryPI/zQyjUL/hGjhqJzfqeWLiH+2j02Iv3UsjsZnnViXO9bFuC8uTe/ioOfLHtachnv2aEhEv/hjQphMYgpQL7uMPuKY1fBjQCy4F+bJ2QGCpbX8ewo0n3d72hrUP+lMlrJRIUXTPIesda67nd1XhgnNawicQ=
X-Forefront-Antispam-Report: CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(136003)(39840400004)(346002)(396003)(376002)(36840700001)(46966006)(107886003)(83380400001)(41300700001)(47076005)(70206006)(8936002)(1076003)(70586007)(2906002)(40480700001)(44832011)(186003)(30864003)(2616005)(86362001)(36756003)(54906003)(5660300002)(316002)(36860700001)(42186006)(8676002)(4326008)(336012)(81166007)(26005)(478600001)(82310400005)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 13:34:24.6598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cfc0c0e-0e40-42ca-50b6-08da869e869c
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource: DB8EUR05FT029.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7112
X-TM-AS-ERS: 104.47.17.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.0.1006-27098.007
X-TMASE-Result: 10--29.267900-4.000000
X-TMASE-MatchedRID: 9mUF1PHF2wsZHQl0dvECsXAqViM7NdjVW+HVwTKSJIYgxeBLaf4ncwMu
        xYHusBZb/E4WsuVas+1xVRAy2CYT5U/w47NVRfpU3nHtGkYl/VppkBMYDn8FeHl7KG7hOkirTXj
        WGR9JhOkiH3zIt2nfrGA8hHmi8u30DDw2a573DPf2TS1YFaI5/xU5qsA/dJ7CZICFYoaFIIWpk2
        /F38tqp4ptbtSUdZD1MU9HuIO9+uro2ZWMy24DXx1kSRHxj+Z57xtPw/8I7HTk6Qbi+9i6D7M1m
        24REs33q9YyptElK5eEf/r3EdDI70vB8k/m3FQqAjTI/+6gf4O061diBteN1y0dCVIQSitS3j63
        YQvEOy88Dxgn2v6xjigocOChcNYWjoR5DwlwBUfO6wQgUuSnLQgqPpbA7sp1OhR0VsdhRrCN3Hk
        V2EiaAyL637QCIVpi8vc3EUpCmrWxQuChZckel6Bw6BKdk7Mx3ttnLVC/czOHOV1iX68qKVchmZ
        cYZfN1n930i8Lkkekwcyw/JIpenV0ieHN50/kHKwi7MItzaY0ejl8XURi8fLgbJOZ434BsDNsxA
        B8+ExTTIvxsPLepwF6Z1+7G+3661du5N7lWKLOD7/vR8cWk+0aYLapw9QQ+Cb7y9s8XSuQWWg76
        IlE/zIVC+Bm0EOS9nN+SUsusOuGojsVP+osNyJIkscdvYoAt/OuUJVcMZhswaoe6trQC0XV12Ag
        UmT2W4EXw14zmtrJppnUGmRQu0h0tktA6Db5fN70wXhI0DX6C7C2rJeUToWoLpLbGy3pUfLB5eD
        FGePV6CjbCJqPaIblxRECWghM+/joUFgZSn5UURSScn+QSXopEa31rsAmVxEHRux+uk8jpP8tMO
        yYmaA==
X-TMASE-XGENCLOUD: 63d8b996-3f27-4953-9a46-d689513258c3-0-0-200-0
X-TM-Deliver-Signature: 470802FDF4164197DEA573874D480744
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1661434467;
        bh=4w1EZ+DLHPfJkhrbHMl+vW90crkFcs+NYaTQWH53hQ0=; l=15606;
        h=From:To:Date;
        b=mwOzD0r0fQufUcgPmOQ2nOuEKhtMHUsZFYuZ8pDpRUyLkGF0jDv0LkQDhOTkuZL9n
         G+5TmvL/XwO+oI41B3bJ31I5sgrgks5VUNFaPFTCJu/S52H3vrzAMgryCTZeFEYwtS
         OaykzvmpTm2cLB7lAyuLRelLAE61ALS0n3nafYZEjiDnkDffVaoI9kS7JJUi86AlQW
         oAdbP13A8WIotGr+P+6jHib7cY6WraunrQ1arS0b0dcxvH9CMOFEwvLpDuo2zDO9Vk
         rizrW8qvyjGmGD5R1cnQreGlqm0BsnopBXVDNOWBm0msYIpLe4D635xmJDwECw6NMi
         y5LbkBm1bo9IQ==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

virtio-can is a virtual CAN device. It provides a way to give access to
a CAN controller from a driver guest. The device is aimed to be used by
driver guests running a HLOS as well as by driver guests running a
typical RTOS as used in controller environments.

This is the reworked (2nd) version of the specification after having
gotten some feedback on the virtio lists and the Linux CAN mailing
lists. (The 1st now outdated version of the specification draft has been
sent out on 1-Apr-2021 to the virtio lists.) There is now also a virtio
CAN Linux driver which in the meantime has become good enough to be
shown.

There were a lot of changes, only mentioning the most important ones
omitting editorial changes.

- Classic CAN is indeed non-mandatory, so a feature bit is needed.
  According to ISO all CAN controllers support classic CAN but it may be
  disabled by configuration. So classic CAN is indeed a feature which
  may not be available in some environments.

- Introduce a new feature flag VIRTIO_CAN_F_LATE_TX_ACK. While marking
  as used after the actual transmission has been done on the CAN bus
  this cannot be implemented reliably in all environments. SocketCAN is
  affected at least under heavy load for TX and RX.

- RTR frames were requested on the Linux mailing list. They cannot be
  supported when the underlying CAN driver backend is a 3rd party
  AUTOSAR driver as AUTOSAR CAN does not support RTR frames. A feature
  flag VIRTIO_CAN_F_RTR_FRAMES has been added to make support of RTR
  frames an optional feature.

- Add le32 flags. There is now a reserved field in both RX and TX
  messages which might serve to contain an AUTOSAR hardware object
  handle or similar in a future version of the specification without
  need to change the layout of the RX and TX message structures.

- Removal of priorities and config space. Priorities cannot be supported
  using SocketCAN, the information delivered in the config space cannot
  be determined using SocketCAN. Support of different priorities was
  anyway too much for a first version of a specification. If priorities
  are supported in a future version there will probably be only 2
  different priorities, normal and high. In a future version of the
  specification high priority messages may either be supported by using
  a flag bit in the TX message but most probably the better solution
  will be to add add a dedicated 2nd TX queue for high priority messages
  in a review comment. But as already said priorities are not for now.
---
 conformance.tex  |  27 +++++-
 content.tex      |   1 +
 introduction.tex |   2 +
 virtio-can.tex   | 229 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 255 insertions(+), 4 deletions(-)
 create mode 100644 virtio-can.tex

diff --git a/conformance.tex b/conformance.tex
index c3c1d3e..db09353 100644
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
@@ -335,6 +337,14 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{drivernormative:Device Types / PMEM Device / Device Initialization}
 \end{itemize}
 
+\conformance{\subsection}{CAN Driver Conformance}\label{sec:Conformance / Driver Conformance / CAN Driver Conformance}
+
+A CAN driver MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{drivernormative:Device Types / CAN Device / Device Operation / Initialization}
+\end{itemize}
+
 \conformance{\section}{Device Conformance}\label{sec:Conformance / Device Conformance}
 
 A device MUST conform to the following normative statements:
@@ -621,6 +631,15 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{devicenormative:Device Types / PMEM Device / Device Operation / Virtqueue return}
 \end{itemize}
 
+\conformance{\subsection}{CAN Device Conformance}\label{sec:Conformance / Device Conformance / CAN Device Conformance}
+
+A CAN device MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{devicenormative:Device Types / CAN Device / Feature bits}
+\item \ref{devicenormative:Device Types / CAN Device / Device Operation / CAN Message Transmission}
+\end{itemize}
+
 \conformance{\section}{Legacy Interface: Transitional Device and Transitional Driver Conformance}\label{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}
 A conformant implementation MUST be either transitional or
 non-transitional, see \ref{intro:Legacy
diff --git a/content.tex b/content.tex
index e863709..0a82212 100644
--- a/content.tex
+++ b/content.tex
@@ -6851,6 +6851,7 @@ \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
 \input{virtio-scmi.tex}
 \input{virtio-gpio.tex}
 \input{virtio-pmem.tex}
+\input{virtio-can.tex}
 
 \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
 
diff --git a/introduction.tex b/introduction.tex
index 287c5fc..e76c8a9 100644
--- a/introduction.tex
+++ b/introduction.tex
@@ -98,6 +98,8 @@ \section{Normative References}\label{sec:Normative References}
 	\phantomsection\label{intro:SEC1}\textbf{[SEC1]} &
     Standards for Efficient Cryptography Group(SECG), ``SEC1: Elliptic Cureve Cryptography'', Version 1.0, September 2000.
 	\newline\url{https://www.secg.org/sec1-v2.pdf}\\
+	\phantomsection\label{intro:CAN}\textbf{[CAN]} &
+	ISO 11898-1:2015 Road vehicles -- Controller area network (CAN) -- Part 1: Data link layer and physical signalling\\
 
 \end{longtable}
 
diff --git a/virtio-can.tex b/virtio-can.tex
new file mode 100644
index 0000000..ef4de7b
--- /dev/null
+++ b/virtio-can.tex
@@ -0,0 +1,229 @@
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
+\item[3] Indicationq
+\end{description}
+
+The \field{Txq} is used to send CAN packets to the CAN bus.
+
+The \field{Rxq} is used to receive CAN packets from the CAN bus.
+
+The \field{Controlq} is used to control the state of the CAN controller.
+
+The \field{Indicationq} is used to receive unsolicited indications of
+CAN controller state changes.
+
+\devicenormative{\subsubsection}{Feature bits}{Device Types / CAN Device / Feature bits}
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
+as used after the CAN message has been transmitted on the CAN bus.
+Without this feature flag negotiated the device is allowed to mark
+transmission requests already as used when the CAN message has been
+scheduled for transmission but might not yet have been transmitted on
+the CAN bus.
+
+\end{description}
+
+\drivernormative{\subsubsection}{Device Initialization}{Device Types / CAN Device / Initialization}
+
+\begin{enumerate}
+
+\item Read the feature bits and negotiate with the device.
+
+\item The driver MUST populate the \field{Rxq} with empty
+device-writeable buffers of at least the struct virtio_can_rx size to be
+ready for the reception of CAN messages.
+
+\item The driver MUST populate the \field{Indicationq} with empty
+device-writeable buffers of at least the struct virtio_can_event_ind size
+so that the CAN device is able to provide status change indications to the
+virtio CAN driver.
+
+\end{enumerate}
+
+\subsection{Device Operation}\label{sec:Device Types / CAN Device / Device Operation}
+
+A device operation has an outcome which is described by one of the
+following values:
+
+\begin{lstlisting}
+#define VIRTIO_CAN_RESULT_OK     0u
+#define VIRTIO_CAN_RESULT_NOT_OK 1u
+\end{lstlisting}
+
+Other values are to be treated like VIRTIO_CAN_RESULT_NOT_OK.
+
+The type of a CAN message identifier is determined by \field{flags}. The
+3 most significant bits of
+\field{can_id} do not bear the information about the type of the CAN
+message identifier and are 0.
+
+\begin{lstlisting}
+#define VIRTIO_CAN_FLAGS_FD            0x4000U
+#define VIRTIO_CAN_FLAGS_EXTENDED      0x8000U
+#define VIRTIO_CAN_FLAGS_RTR           0x2000U
+\end{lstlisting}
+
+\subsubsection{Controller Mode}\label{sec:Device Types / CAN Device / Device Operation / Controller Mode}
+
+The general format of a request in the \field{Controlq} is
+
+\begin{lstlisting}
+struct virtio_can_control_out {
+#define VIRTIO_CAN_SET_CTRL_MODE_START  0x0201u
+#define VIRTIO_CAN_SET_CTRL_MODE_STOP   0x0202u
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
+otherwise it is VIRTIO_CAN_RESULT_NOT_OK. The device marks the request
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
+Messages are transmitted by placing outgoing CAN messages in the
+\field{Txq} virtqueue.
+
+\begin{lstlisting}
+struct virtio_can_tx_out {
+#define VIRTIO_CAN_TX 0x0001u
+        le16 msg_type;
+        le16 reserved;
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
+The length of \field{sdu} is implicit in the length of the device
+read-only descriptors.
+
+If transmission of a CAN frame type is requested for which support has
+not been negotiated \field{result} shall be set to
+VIRTIO_CAN_RESULT_NOT_OK and the message shall not be scheduled for
+transmission.
+
+If \field{can_id} or field{sdu} length are out of range or the CAN
+controller is in an invalid state \field{result} shall be set to
+VIRTIO_CAN_RESULT_NOT_OK and the message shall not be scheduled for
+transmission.
+
+If the parameters are valid the message is scheduled for transmission.
+
+If feature VIRTIO_CAN_F_CAN_LATE_TX_ACK has been negotiated the
+transmission request MUST be marked as used with \field{result} set to
+VIRTIO_CAN_OK after the CAN controller acknowledged the successful
+transmission on the CAN bus. Without feature
+VIRTIO_CAN_F_CAN_LATE_TX_ACK negotiated the transmission request MAY
+already be marked as used with \field{result} set to VIRTIO_CAN_OK when
+the transmission request has been processed by the virtio CAN device and
+send down the protocol stack being scheduled for transmission.
+
+\subsubsection{CAN Message Reception}\label{sec:Device Types / CAN Device / Device Operation / CAN Message Reception}
+
+Messages can be received by providing empty incoming buffers to the
+virtqueue \field{Rxq}.
+
+\begin{lstlisting}
+struct virtio_can_rx {
+#define VIRTIO_CAN_RX 0x0101u
+        le16 msg_type;
+        le16 reserved;
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
+The actual length of the \field{sdu} is calculated from the length of the
+driver read-only descriptors.
+
+\subsubsection{BusOff Indication}\label{sec:Device Types / CAN Device / Device Operation / BusOff Indication}
+
+There are certain error conditions so that the physical CAN controller
+has to stop participating in CAN communication on the bus. If such an
+error condition occurs the device informs the driver about the
+unsolicited CAN controller state change by a CAN BusOff indication.
+
+\begin{lstlisting}
+struct virtio_can_event_ind {
+#define VIRTIO_CAN_BUSOFF_IND 0x0301u
+        le16 msg_type;
+};
+\end{lstlisting}
+
+After bus-off detection the CAN controller is in STOPPED state. The CAN
+module does not participate in bus communication any more so all CAN
+messages pending for transmission are put into the used queue with
+\field{result} VIRTIO_CAN_RESULT_NOT_OK.
-- 
2.17.1

