Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC785B7C50
	for <lists+linux-can@lfdr.de>; Tue, 13 Sep 2022 22:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiIMUwm (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 13 Sep 2022 16:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiIMUwl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 13 Sep 2022 16:52:41 -0400
X-Greylist: delayed 666 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 13 Sep 2022 13:52:38 PDT
Received: from mx0b-0054a801.pphosted.com (mx0b-0054a801.pphosted.com [205.220.172.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FDA7539F
        for <linux-can@vger.kernel.org>; Tue, 13 Sep 2022 13:52:38 -0700 (PDT)
Received: from pps.filterd (m0208804.ppops.net [127.0.0.1])
        by mx0b-0054a801.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28DIGFKx026927
        for <linux-can@vger.kernel.org>; Tue, 13 Sep 2022 20:41:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsara.com; h=from : to : subject
 : date : message-id : mime-version : content-transfer-encoding;
 s=samsaracom06092020; bh=N9iNtUQYOSdffVpFuO7zf+ssrxKADR28E6hLJ8S3SJ8=;
 b=a5wENn/5bxKrI4O806srPwE3nMkdIEi9ManXKC9jPFWkEBAMu+TqtGPVc2IIorA8TcM8
 vch9ynSL1mQYAXcm1rd8zK6oOD9aC/yOnQDWq4ZbXFGyxfKM9jt7dFd2Sx0ARXsuGwZJ
 hyPWj5YTLo90Ge3uXY4qhDTYrZBcrVXVdyWuX798m73wq/7OERPoSCw0DnRVhde2WOvh
 iPX7UNQrOY0DMqg3vVwG2SJ6AsXG5KN48Ev3NXbGNnpGx+vLoQ22Q701T7OPY4Aj7s8p
 13YQB3Btj1TPxd6JZj59ZgdBbsjwfs/ZYeDAMealOeIWqKQV2o1KSUKiCFg3U2w3F4ls dA== 
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
        by mx0b-0054a801.pphosted.com (PPS) with ESMTPS id 3jjy07r6ab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-can@vger.kernel.org>; Tue, 13 Sep 2022 20:41:31 +0000
Received: by mail-qv1-f70.google.com with SMTP id ec8-20020ad44e68000000b004aab01f3eaaso8858107qvb.4
        for <linux-can@vger.kernel.org>; Tue, 13 Sep 2022 13:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=samsara.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date;
        bh=N9iNtUQYOSdffVpFuO7zf+ssrxKADR28E6hLJ8S3SJ8=;
        b=cZ3e3x5YWnXnOFVtNkeVfOdHTO+pv10FlLr1pKb0VGpp0gH/ylPO3nWTmlnyMMKNEM
         w2BlJ8ifZKHsiG1DJKGnFFCOIddXTjNiJp4OkNFJakW1B9ssFf9mJ9vQrQCPSHIlTcsy
         e7bhGwRO7V3hrPdOYsEjZpUB+hVsaNskswp5gYtZBgqGDyCnZDnn48ujfPZdC6QYfUDs
         Z34/to3VD+OTjiKUd/+fj87aeza+kcQz0mXNPCv7wP7lR5jmJ/m1ycAOzJZdBbYXS4qk
         dCAUsGTyn1vG55yuQJMPOqPgb86Pukux8QiE8JaG7/QaNGbCWxZdD20sgu3zPUkICMOB
         9sMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=N9iNtUQYOSdffVpFuO7zf+ssrxKADR28E6hLJ8S3SJ8=;
        b=fqETl30phQfKXmj0v4LkHfdZd07JvYfpNL+Gfg+aGb1oe5DAF1qiEosn8qJv774fkH
         qgA1Bv/Q+s7Hls7PiylDYJHM3V/wJMSCHV5mac1GuN+GCe0zvHZlklk4xMO7L+7pDFVV
         iC6dU0QOs+mkWcXulIMPduas8hQbfMMw/q9amgUBzw1CmA0oi6Lk9y8QJhnu76GlJ4Qz
         JL/RHF3+kuYJoybu2BKYqFImtwSWVrtSyiPAU0jlRDyp/Uw0nAEhn2fBrgNlzy3KlhxS
         /9LbTqXOg9mGiIazFb6xDzf/kku/CDkJxOusHo7vxTzCPmkMoscmEa8c/k4uNVxKSG5C
         5ALw==
X-Gm-Message-State: ACgBeo2+GhCy5QXUiOqxZvm+jiq5piK8P6EB5syyXpciz/OhXafJX9lS
        mOYCqhTNH1DTfe0MlhwKNBUiKBvmFIJ1ohU7T3lRxY82y3TRVtvxN8zwhwUFsSEti9eX1404X8T
        JdA3TG5nIeHHwX/HAm4IQ
X-Received: by 2002:a05:620a:895:b0:6cb:e24c:992d with SMTP id b21-20020a05620a089500b006cbe24c992dmr18116251qka.221.1663101690336;
        Tue, 13 Sep 2022 13:41:30 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5Olxrm+SqC3Swx6qvp9rhMwvwvOiSD2yhU8RtVdwXyzZrrpFp0fGAHqrCdm1gS3hN+1v39wQ==
X-Received: by 2002:a05:620a:895:b0:6cb:e24c:992d with SMTP id b21-20020a05620a089500b006cbe24c992dmr18116242qka.221.1663101690080;
        Tue, 13 Sep 2022 13:41:30 -0700 (PDT)
Received: from downhome.. (ec2-184-72-5-93.us-west-1.compute.amazonaws.com. [184.72.5.93])
        by smtp.gmail.com with ESMTPSA id x5-20020ac81205000000b00344f7cf05b4sm249236qti.14.2022.09.13.13.41.17
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 13:41:22 -0700 (PDT)
From:   Rhett Aultman <rhett.aultman@samsara.com>
To:     linux-can@vger.kernel.org
Subject: [PATCH 0/1] can: gs_usb: remove dma allocations
Date:   Tue, 13 Sep 2022 16:41:09 -0400
Message-Id: <20220913204110.89730-1-rhett.aultman@samsara.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ygtKZuV6Nl4mRugPrCsVIK6O-mpk2PHN
X-Proofpoint-ORIG-GUID: ygtKZuV6Nl4mRugPrCsVIK6O-mpk2PHN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_10,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2208220000
 definitions=main-2209130095
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Dear USB CAN mailing list members,

In a previous thread reviewing my changes to stop a DMA memory leak in the
gs_usb driver, a discussion ensued about why it (and other USB CAN drivers
were using DMA in the first place.  At the time, it was suggested that we
perform an exploration to determine if there is any performance benefit to DMA
or if the DMA allocations could be replaced with normal kmalloc( )s instead.

A method for gathering this information was proposed here:
https://lore.kernel.org/linux-can/CAMZ6Rq+FSzy5ijQZhYyVJrbe86U9faD5aPFO4cezNkN9G-USzQ@mail.gmail.com/

A member of my team found some time and resources to work on it, and so I'm
communicating his work to the list as an RFC on his behalf.  We are seeking
input from the mailing list regarding his testing methods as well as his patch.

The short summary is that he couldn't identify any meaningful change in
performance on his x86-64 hardware.  We should be able to also repeat these
tests on our ARM products under and older kernel and perhaps also on more
modern ARM hardware such as a Raspberry Pi.  This might give us the confidence
we need to consider removing DMA allocations from the gs_usb driver and
perhaps others.

His detailed notes may be found here:
https://www.dropbox.com/s/c3gm3oomihdze1n/USB%20CAN%20Driver%20DMA%20Removal%20Testing%20Doc.pdf?dl=0

Feedback is very much welcome.

Best,
Rhett Aultman
