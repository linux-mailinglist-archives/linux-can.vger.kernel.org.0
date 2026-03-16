Return-Path: <linux-can+bounces-7087-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNutHL8FuGkWYQEAu9opvQ
	(envelope-from <linux-can+bounces-7087-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 16 Mar 2026 14:29:35 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 290F529A5EF
	for <lists+linux-can@lfdr.de>; Mon, 16 Mar 2026 14:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6775A3048052
	for <lists+linux-can@lfdr.de>; Mon, 16 Mar 2026 13:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70277397680;
	Mon, 16 Mar 2026 13:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dge2AQAK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aZ9l9Yu/"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA53396B67
	for <linux-can@vger.kernel.org>; Mon, 16 Mar 2026 13:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773667202; cv=none; b=dCgc5y7PYzTZIjoU5WqCgDy3o9+FSqzsRbhBXOBDaTa0jR154D2JpUubmzxadm1FPXfvStL7SnDvZjk7sTHXLTsp5CcP7F6pkL2hzhi/r2AcdXYBVLndP/C6TU5wZWGdLWN4m0EoPS4uydtvGCNwwB9wdYD8iNAOpeqh4vBtXr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773667202; c=relaxed/simple;
	bh=QlyRtyj6riE8FuflIvfBiM4ASu5Sv7E5TNQKsnxXv80=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=tvIRILvTrxmFj/0ORfAGFq+cHfhmA/ENyGSNMMmMuReBkgUocqNY2pyePGQBUCPUEaPJjaO6fUGEFHqnfHJDDr7Ptgh7MssCMQ7/QpVrSZj19E6rCZRo6J10gwuGzvxxushoIF8Gl7knuabdc4k++/nuqUbv9cjMydiYAuZaYsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dge2AQAK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aZ9l9Yu/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GBjOnJ1724715
	for <linux-can@vger.kernel.org>; Mon, 16 Mar 2026 13:20:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=7SGS5jQKh5vFco8jAnNdL8
	iZz9tDRrOLuUjo/nn5l2Y=; b=dge2AQAKPfXtrrGa1DhDkKG1atwaUlv1wCxMnh
	pZfX4RIcW0Awv9rrObrEi/3sgtlVsus/TqvDGX0hzzykXJfG8vRso8Z1VBvAYKEt
	QABcYA3cMuESMVSGkU55YnF7Nombpr8xkjtPdXV5eQdwFo7nxO49UafRh0GLFbhG
	vC3Q9txyhbWWQBzg1QAcAERc8fmcnumy0vxOqCwTEBVeMj9Bvq1IHEkr+Wu08a2+
	mS+YHiLUkRIScdlvMoxeiZrMfxUP81Qj5lxXx1p4pr1ZZxOKy4XhIDXkdAV2gQsi
	nD1QJyVOIvsv8Rt4ticdCW5zaVCSedx8wJC0D7NTKZtEcZ/w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw0udnsey-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Mon, 16 Mar 2026 13:20:00 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35b901d542bso14301061a91.3
        for <linux-can@vger.kernel.org>; Mon, 16 Mar 2026 06:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773667200; x=1774272000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7SGS5jQKh5vFco8jAnNdL8iZz9tDRrOLuUjo/nn5l2Y=;
        b=aZ9l9Yu/Z210n6+gSnmMv+jOhzlyXtKC19XvQD/kznQ4fzDwAiL+aYcS/9kbOR6rm1
         0L62qudBSMQXlngHEPbK27kpwhgnCNUITbTxPLfscuEG3/Dnyjmgr+nYXtMP4DpxKlyF
         jdx1P2WjW/iGPnG0n2Djxq3tPEQom+EDaGAyVuWQPtFnOSQKSx4aJbDc3dnrs1D7kAvr
         29nT3fG0zr1Jn2UhtPlS5rBvNtEWfX3ci0iHVL65CsuRE8i/iXq+75JPDqVjvAFfkl6H
         geRCQ+XFiSpwG50d/Z6quEyNT7l5Zz9r1+3inchsOJkayBiuKxwfqJnKpK45PhNslG87
         dqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773667200; x=1774272000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SGS5jQKh5vFco8jAnNdL8iZz9tDRrOLuUjo/nn5l2Y=;
        b=NQEZEvUU4t2pDuftfhnP171tUKMoCpkQjI38T+x1BQR6W2YxKoPXhpTGDyR+NPbQXf
         +8nN8+RNnxXhdlF1J9IcUTWL1TZMVJDMUrUabQklz/4Ot/9ilS0yqM7f55AaazbRj4we
         8/wGMXBFG1zaYwgNN0bAZHf0dYb5eBBMi1DjJgNJbQjwU9ON+JAUR1UyYaf3/S/92fpN
         AEtyQ+C6nTwsiDU7zX2v2g77Bz7/MCCncslD7wOU1Cba2UH6nOI1pznH6gcyKeINIR+P
         gtCDDfIFYCZfiT4CsiklOZYHSU40xgPvycXU2STscNNPhokeKxZwowsu0+D1u8S13UUo
         2DGA==
X-Forwarded-Encrypted: i=1; AJvYcCVcnoWhUbZlMBAzycxyGP3R36Ggn9yTRI7EEj8TKQvsdKkiUuGSTu6kv2jVOdTlDxV0y/qoVYkR8x4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3P8SLYRzJxnpS68cza7OLizb2MaSGE5HD5H7FB6lqPRiqgqkh
	nmcI5cje58nvHYK1xHS6NH7nAGAL164PGwHfTAm1wpCdcMWK227C/pJyZBVRjSpHUr4qnW5GssE
	x3IhK3b+YoE/bN971YA0UCcEqkvfekG40S7vXvb8iV0hOblN2aGILovU/dXfovRg=
X-Gm-Gg: ATEYQzzzMBP3lIalGXljPy3ZaQGtMRiXxn3cdRBxnDHxyG2oGNw3N1hP8Rk4LPTYICQ
	3Kagz0Cz2svl3/BkovoOvVKa5R+vz4a6TH5cIAm5atTzqfPjzUzqnldnkYXt4hzLHlpM9byCA3V
	b4JRiT6Zlffn4QA2ZQHvupwQECDH8s0CYx4S4FfjXBLzfzyjd1SqhGFN2nMOxGtJuy6sjkdvfjt
	DGmHZmWRAWSfE/7LfRIaroqF6nnv5FXBGFMhHk79kJN5kCx+GfCzsVbwW6hsSyZT65N3V4vUMsm
	dwcBm+d5ExJILVcF8WnGK+uSi+GA/WJ/qavdNnJHdAH4bpwcEF/se+Wo/Xu499nUCdSCbbOD+4O
	yJPrZirj+EZYb51hWWpT9gsYzAY8Rsj+a2YjfKIVIcWKhPZFxcf36VK4CjQ==
X-Received: by 2002:a17:90b:5306:b0:359:ff8a:ee4f with SMTP id 98e67ed59e1d1-35a21e2fcedmr12435836a91.7.1773667199479;
        Mon, 16 Mar 2026 06:19:59 -0700 (PDT)
X-Received: by 2002:a17:90b:5306:b0:359:ff8a:ee4f with SMTP id 98e67ed59e1d1-35a21e2fcedmr12435811a91.7.1773667199067;
        Mon, 16 Mar 2026 06:19:59 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35b9303eb9bsm5209648a91.8.2026.03.16.06.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 06:19:58 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
To: mkl@pengutronix.de, mani@kernel.org, thomas.kopp@microchip.com,
        mailhol@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v2 0/3] can: mcp251xfd: add XSTBYEN transceiver standby control
Date: Mon, 16 Mar 2026 18:49:47 +0530
Message-Id: <20260316131950.859748-1-viken.dadhaniya@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BJ2+bVQG c=1 sm=1 tr=0 ts=69b80380 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=BLoY-fwtqX9uGLcRELsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: 8gJ3l9iqukPGRATpp3pQ5R6yDWrONrEH
X-Proofpoint-ORIG-GUID: 8gJ3l9iqukPGRATpp3pQ5R6yDWrONrEH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEwMSBTYWx0ZWRfXyObv7weU0y9g
 RNUXCP2J0lXrtKpe4pUbfltrleevzmIYYpIZ3HyAqCQy+UaPlFvEkR17AUtJW+kHnlInYue1czn
 9Ee/C36oJB+5UtVhWHATCeb9Ahfhm8p4LkdgcX/b2fzLzVG62cViQ3Eu1b1g5gkWx1tXMvcSSmQ
 aZkPu9mmNudANehkXTbFBD9Sq6RkauPZUHp7QE3Q4MNlJU7vuYZ1th9Wb89lgj639AnL3jjM0Cn
 CJYnQolU5KYsOCjBfStkcgf+pW093+UoFwtcKHlJTTzqr3K0FcngdEA1qUZNy1h6ZogA+/pT+Vb
 HLG4q8gNF12rboXgN4dNEpdqRyj/OD4oCxuWHK7a19Vi6Ey0pyMYzI4KwaHjADdYlBvUwE1dFet
 2zdqiH7M+MSe/EYSuFbMh4RXGEVTViHCQk07dF6sXP++93VGp04PYjAsT4C7ikPfy0VPiP+dDpq
 Ak4GIbg0aftnN1g88Iw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160101
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7087-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viken.dadhaniya@oss.qualcomm.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 290F529A5EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series adds support for the MCP251xFD's dedicated transceiver standby
control function via the XSTBYEN bit, and enables it on the QCS6490 RB3
Gen2 board.

The MCP251xFD has a hardware-managed transceiver standby control on the
INT0/GPIO0/XSTBY pin. When XSTBYEN is enabled, the hardware automatically
drives the pin low when the controller is active and high when it enters
Sleep mode, providing automatic standby control of an external CAN
transceiver without software intervention.

Testing was performed on the QCS6490 RB3 Gen2 board with a PCAN-USB FD
adapter, confirming that:
- The transceiver is active (pin LOW) when the controller is in
  normal mode
- CAN communication works correctly
- The pin is automatically managed on sleep/wake transitions

---
v1 -> v2:

- Drop the gpio-hog approach as suggested by Dmitry.
- Enable hardware‑managed transceiver standby control via the appropriate
  Device Tree property.

v1 Link: https://lore.kernel.org/all/20260108125200.2803112-1-viken.dadhaniya@oss.qualcomm.com/
---

Viken Dadhaniya (3):
  dt-bindings: can: mcp251xfd: add microchip,xstbyen property
  can: mcp251xfd: add support for XSTBYEN transceiver standby control
  arm64: dts: qcom: qcs6490-rb3gen2: Enable CAN bus controller

 .../bindings/net/can/microchip,mcp251xfd.yaml |  8 +++++
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts  | 22 ++++++++++++++
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 30 +++++++++++++++++++
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h     |  1 +
 4 files changed, 61 insertions(+)

-- 
2.34.1


