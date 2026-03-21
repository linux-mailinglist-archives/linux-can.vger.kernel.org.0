Return-Path: <linux-can+bounces-7204-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAIoLkOivmmLVAMAu9opvQ
	(envelope-from <linux-can+bounces-7204-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sat, 21 Mar 2026 14:50:59 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2033F2E59DA
	for <lists+linux-can@lfdr.de>; Sat, 21 Mar 2026 14:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDF9E300F510
	for <lists+linux-can@lfdr.de>; Sat, 21 Mar 2026 13:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB062BD11;
	Sat, 21 Mar 2026 13:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JnhFWPjf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ilL7vhbY"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E5D2F1FD7
	for <linux-can@vger.kernel.org>; Sat, 21 Mar 2026 13:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774101045; cv=none; b=uvVfKisgTSb/UvimeQpnq5CVlPREuZc6RyzBaW72BJVg9Cv0XR3cMNkhTd9e0bbOxB4I6WRka+sQeseeX0od25/qBQpS+u2anqrcbekEihirvJi/hocIg5p/bb1THRkpxUySbJA40M7YArXlIWK00tZBUejufcAhk5ut/5hjXMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774101045; c=relaxed/simple;
	bh=mKHx+VfRPQw/ItF5UDbBI85OytKLSDar0Sp+oJ606Rs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ZFfMlBIv4IfSeXh5OGYu6IPKLnOxIRUaQ9Thz2gxmOHhlsLaTKvvcw01U0qgFv4+mzqTjsGAFCR8r794TmhAoO8gk/pw6XCqEqvT9uYg/d2PxJDR6DgTD8btSBMR4mZW9DvAuCikQn4io4aSDLIEi8NT1s3cYIYnu3/4ln2VIGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JnhFWPjf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ilL7vhbY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62L4mt3M4020523
	for <linux-can@vger.kernel.org>; Sat, 21 Mar 2026 13:50:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=nXecX1NuKNC16BMQb4qBGz
	Rq5LjOcebRUD8yZZIJjtw=; b=JnhFWPjfrRRzGgmN8G1UB11yazMPXDNiLX9wYg
	/Q8ibRyHtgg+Wim71lhmhzMeP9NRlj4P8rUr+N6ats37jli4b2idNA0yrd/+Vm4Y
	3bU22VzXmLk21GwcQ9mGaP9aJbJj+j3rf9A9CYIDA5gHL/HqrP6I5m8EVZTHK9J0
	YWjxdIWd5kZJBNE3zIKPH3426f1IaM/OHXhQupNVCXSALqQVyaa7ZMxvN5xYSwaY
	zqVkNdZOlsD+S66gPW2creujUKcHZil23kxNsMmq9FsmWPLiq5mhNpNXhWH+8Pts
	ifZfK00xcrCsyRN2LzEPsny6vqAPMynObd2WqqMEDHrRY5EQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1jwvgtj2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Sat, 21 Mar 2026 13:50:42 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b091c3f891so941165ad.3
        for <linux-can@vger.kernel.org>; Sat, 21 Mar 2026 06:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774101042; x=1774705842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nXecX1NuKNC16BMQb4qBGzRq5LjOcebRUD8yZZIJjtw=;
        b=ilL7vhbYBqiIpj4K1/MJbPnXdlPNTeI86uD5qjtQ8vNNluwOSYyR9+vVWUQW8+Cb0O
         u4ianka/Ny7FcoVQUcWJUdZnn9fPU8xnQDHZtqKPCDdB4VMEsBH736OExFWmgs46TZsU
         34GnBB90SJPfXnI5B9ATE2nfBiglDQVEcv5BHYviAp0SgjDPda3TU2xxUHhBi3kZy5Xy
         1WrETDbLR7og+uhySC2HdZZX/9T49ezGclnlT36ywhZItVJqbsPGQ6SkgCnR5l3IkpRD
         BC7wEXRYl0Htv1RFr29B8mRVqLjT0BK0FR8jnU6CI8A1Qsh3CvrryUhO/jSAZKF/ITOL
         uxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774101042; x=1774705842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXecX1NuKNC16BMQb4qBGzRq5LjOcebRUD8yZZIJjtw=;
        b=pNrQHHc36e+slDpwyA7xEHD024S+PaEWxWYEVxCVhpirdZc9T+x9/wx8t4yXY9Quia
         zMSB0eyRZ8ESayYK4NiPMbHT41y8uipV5AqHPJl3TulRtfxAb2bIpmhNpzg4SyHoKRX9
         R2f7Ljx77lAlNSW3V0nxqNOy3WAVbSDgXn2SxiASSk5dGP8fVQZTtk4wK8wp1hVxFxFb
         ltQk4TYscmZwSmz+D2sx3RM/uh3Uw6aqvsp92IZF1Z3uygxd8cnab/gErHFjqxspRNAo
         VsAO0hxMiUndSWt2pyQIVD6e2IgZ49jaKFSdk5jidVIyy82GWcIE2KBWpb7ZVZxD6Vr+
         PjHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkHQNL80vJ8h50R1sqTHoDAalfRRw1QgsqbzVXRsuJ83BhD8L2TrRnMOSzyWAuDc9UMzGaQ8G5Gyw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Tdlg8LXtfrW4yZrTGOEha8QlrwscsSv/uPOq8pAVuw/wCIrm
	o2Iw/cucfCtSiqglTmNKl4IufJS5C5Lv63kY/Xb8Wv1B5k31mvDHE0iEFp/UEx4gq9DeeSqQr6k
	m9ybYYjnAequZw1FhgPMsI8zBmrCzsZevsfBC1iAVwZYckg/gtPza7iyHpWCZbs8=
X-Gm-Gg: ATEYQzyEOJyT/qDBM0/snkR/SeT9yqHHrlwfaBIKMKIWLZgKvAfdEjw8C0B1OXI+xNG
	kVRReEoN98lLOPRH2EeF2W+WimUy6kZrmRoL7kvhX2plbUdvUMKzc0he618uIxOJ7OXcSx373JL
	ZmqeKS+vTMAR/xIqhFQw0Perq+PSNY1VEti43t/O4JtPwrxzJ+ulwzBcaSiQg43UC6dpIvuXgzB
	GAq2QAVj6gX09pQmUiwGhFTfiMm/E5bjLEEw/xLcoTMjR6T0WRbxQ9q6utfqM2/FJDKVgollULA
	K+Jd0GMgKbrAaMLErtTo/au9/qveFyk/DZsNiOHl4iNcC7OpMuF0tWYCROoE5kl8EG51VqpA/1d
	msKacGkNh7XOKPpfHGzTNlHlPCK5HbzeIJG8xjt3g4wg5LzjD9iPlU2mZ6Q==
X-Received: by 2002:a17:902:ecc7:b0:2ae:5163:c2aa with SMTP id d9443c01a7336-2b0826feed5mr59028865ad.20.1774101041718;
        Sat, 21 Mar 2026 06:50:41 -0700 (PDT)
X-Received: by 2002:a17:902:ecc7:b0:2ae:5163:c2aa with SMTP id d9443c01a7336-2b0826feed5mr59028695ad.20.1774101041170;
        Sat, 21 Mar 2026 06:50:41 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083516cb9sm54897555ad.2.2026.03.21.06.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 06:50:40 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
To: mkl@pengutronix.de, mani@kernel.org, thomas.kopp@microchip.com,
        mailhol@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        linusw@kernel.org, brgl@kernel.org, linux-can@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v3 0/2] can: mcp251xfd: add XSTBYEN transceiver standby control
Date: Sat, 21 Mar 2026 19:20:29 +0530
Message-Id: <20260321135031.3107408-1-viken.dadhaniya@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIxMDExNSBTYWx0ZWRfX1vUJ0H8qtJAm
 j6YDYiXoUXz4oovJCBSoMdhiWo1SewzT/8NMYyvD8jO3SJKhfg+FGHTFIUJP1U3cAvGe/QirYYl
 PiOlokOmflXL6uAniYXMOC/i2q0o8ZYa2l2ZHGHtE3tM0whpd8WNYzTeIXt+NCTrMaOyxCJ6oOf
 2XPR6vLyG/PtTEdlKENIkrK9Pck7du0Umzbu77HAtdlGhEl8ufVFz7/wKSwvgqO5TrZw8EP5x0K
 IUxhIyAvkfbJGR1m37t4fqgWJrZZbLngUT/EmaZvkNe8jld+kLnS1bE22BoUaef9CH+XUMWIyHB
 y8L4zhI2P9o/NnvFt7N3aq55Sav1KT8A0m+ZKu7hHpLkOwxgF+MGTlrVa3S6xX2Fgm2ovQIj7as
 BWi6Hj3SkslhLujgQTsvTbA1GAqwjVRy/sr8Bm9GvrjZHPwOMCQNMvQu02UOhhkyJYjJ96Fxwio
 Ql79nLqAKABJVqJlg5A==
X-Authority-Analysis: v=2.4 cv=bcdmkePB c=1 sm=1 tr=0 ts=69bea232 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=3aoVsspQhmqNhTY_ZuUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: hH9I6_Vzz7YX7OI9bZvbITk0bZONWHdc
X-Proofpoint-GUID: hH9I6_Vzz7YX7OI9bZvbITk0bZONWHdc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-21_04,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603210115
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-7204-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viken.dadhaniya@oss.qualcomm.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2033F2E59DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The MCP251xFD provides a dedicated transceiver standby control function
via the INT0/GPIO0/XSTBY pin, controlled by the XSTBYEN bit in IOCON.
When enabled, the hardware automatically drives the pin low while the
controller is active and high when it enters Sleep mode, allowing
automatic standby control of an external CAN transceiver without
software intervention.

This series adds driver support for the XSTBYEN-based transceiver
standby control feature.

Tested on QCS6490 RB3 Gen2 with a PCAN-USB FD adapter: the transceiver is
active in normal mode, CAN communication works correctly, and the pin is
automatically managed across sleep and wake transitions.
---
v2 -> v3:

- Dropped device Tree change from this series.
- Configure xstbyen pin before bringing the controller into normal mode.
- Add a check in mcp251xfd_gpio_request() to ensure that GPIO0 cannot be
  used when xstbyen is enabled.

v2 Link: https://lore.kernel.org/all/20260316131950.859748-1-viken.dadhaniya@oss.qualcomm.com/

v1 -> v2:

- Drop the gpio-hog approach as suggested by Dmitry.
- Enable hardware‑managed transceiver standby control via the appropriate
  Device Tree property.

v1 Link: https://lore.kernel.org/all/20260108125200.2803112-1-viken.dadhaniya@oss.qualcomm.com/
---
Viken Dadhaniya (2):
  dt-bindings: can: mcp251xfd: add microchip,xstbyen property
  can: mcp251xfd: add support for XSTBYEN transceiver standby control

 .../bindings/net/can/microchip,mcp251xfd.yaml |  8 ++++
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 37 +++++++++++++++++++
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h     |  1 +
 3 files changed, 46 insertions(+)

-- 
2.34.1


