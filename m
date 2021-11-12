Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9077A44E62F
	for <lists+linux-can@lfdr.de>; Fri, 12 Nov 2021 13:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbhKLMQb (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 12 Nov 2021 07:16:31 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:47993 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbhKLMQb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 12 Nov 2021 07:16:31 -0500
Received: from photo-meter.com ([62.157.68.230]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MFJfN-1mwn1u2qtd-00FnQa for <linux-can@vger.kernel.org>; Fri, 12 Nov 2021
 13:13:39 +0100
Received: from [192.168.100.109] (MICHA.fritz.box [192.168.100.109])
        by photo-meter.com (Postfix) with ESMTP id 80B4D3B08B7
        for <linux-can@vger.kernel.org>; Fri, 12 Nov 2021 13:13:04 +0100 (CET)
Message-ID: <5215c43f-d208-4bc6-5bd3-3425bc4f107a@photo-meter.com>
Date:   Fri, 12 Nov 2021 13:11:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
From:   Michael Anochin <anochin@photo-meter.com>
Subject: can: m_can: m_can_read_fifo, can_fd_dlc2len returns sometimes
 cf->len=0
Reply-To: anochin@photo-meter.com
To:     linux-can@vger.kernel.org
Content-Language: de-DE
Organization: Czibula und Grundmann GmbH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:HDhj8AjVsDsjsoSrDK6rQR/iXGDVf+v8VXE9PEiyKF3MHH5YBAQ
 SzmUAKxc5bTM0uhcmvIawGck3+k952MwqR/mCjYPyUTlNJDjjCNtmXZqULWINNAaR5oWqFo
 nP6X7BiV5JcrKFDaA/AeuLUjpzDlOpBqi6AWUsPEaXG5OK1tCkhRBCIr++Z3czshZmgElaq
 Gb0WkDJ5pHxMAwyD2Qcdw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3hXYdZjLfyI=:+KLoQwgMBULq7Or0GMfUzI
 D57RS5LLrH0jL9D5bF6TqyaO142fxRgb3SU7u2TxifP8uNwvxmQy5Gh9N6wHYq1hcDKe7Io8P
 PPz02YsVyh8Ir0ms9PmDTzVmPIVGOsjj5rkeUJXiq8O9IRZGI9FAH4lEW/gbTbZkAhbu1EiTq
 vwYEb7glc4Eh3FbD/EIw0Zss1n8vUVmoqzKO+qvhuppSkmiuI6KaBHHqgObylGpZp7FhvrCv2
 AjljJ3IXL8LBBN8+qnrCa+E2yyVsMKeaATxfcCHQe2YOHIyMx+ok7NMa13LCylkwOd3wCTUo4
 XdFwnF/ks2e72yKj052VQYu1MGAcB+oPmi3RC1p9UhMYyOwFdwqUO+zTrMUWyhh6Xi6VGNbxu
 LcpyltSD5H+V8bm7/TSogie9yAEtZyDDKRzvZ32CFNd0Tlkj4Zh87VznEcvxx81toX8e706A5
 /5Z3/Gx8dMS0wW9XjWU7CrQXdpJKjswfoBm6c4n3S01OJWyU5fjS9HZmy13eYvjkWCn6Flcfh
 SRXj6LKUmHGhi5CaDXYgf34dFh+msMmEFfrJSaE7yqPWjVb5rlKzl4at0kuvR1rEBA89syVSP
 wmvmFiycOpSIHfquExyH1wSeemJ4EZ/hE/Usl4hQeeKEcZ4cGsp7DQRCivqEsBL4lnggy0QcW
 ihSgG5eIVcC+oRi000iB2DKD83bHbL9qJqHkg08ov/BAQHW4cBMe67rqUeY76kwr/IlztTHaB
 aez7dkIsoHU8kkQV
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

I use tcan4x5x over m_can driver with CANFD tcan4450 chip. Sometimes 
after continuous communication I get in dmesg
tcan4x5x spi4.0 can1: FIFO read returned -22 . After that nothing works.

I have followed this behavior up to can_fd_dlc2len and found the following:
1. in m_can.c,  function m_can_read_fifo does
     cf->len = can_fd_dlc2len((fifo_header.dlc >> 16) & 0x0F);
     cf->len = 0
     DIV_ROUND_UP(cf->len, 4)

2. m_can_fifo_read(cdev, fgi, M_CAN_FIFO_DATA, cf->data, 
DIV_ROUND_UP(cf->len, 4)) returns error because val_count=0
3. Following further chain with val_count=0:
     cdev->ops->read_fifo(cdev, addr_offset, val, val_count) -> 
tcan4x5x_read_fifo -> regmap_bulk_read -> ret -EINVAL

I can try to look deeper at fifo_header. Perhaps someone has the 
possible cause of this behavior.

Regards,
Michael

