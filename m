Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE7D32E850
	for <lists+linux-can@lfdr.de>; Fri,  5 Mar 2021 13:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhCEM0S (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 5 Mar 2021 07:26:18 -0500
Received: from smtp-33-i2.italiaonline.it ([213.209.12.33]:54244 "EHLO
        libero.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231492AbhCEM0H (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 5 Mar 2021 07:26:07 -0500
Received: from oxapps-14-080.iol.local ([10.101.8.90])
        by smtp-33.iol.local with ESMTPA
        id I9WslIUnBR8VAI9Wsl3gLh; Fri, 05 Mar 2021 13:26:03 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1614947163; bh=Yc0TfhRZGTR0U3jiRn64k40NMIPPHMMuV8c/3SVhov4=;
        h=From;
        b=GP3ucQV1AfRTv3cvtnISd44N1hF56EQorwKkkn5huFbO0v93m6HbLQpYtVybpzb3B
         Vw7tgthlQV9TXiVSnjzzeSLHi+n+McEqfmr4y7hONiGoV3Qh3hwo+nqWNwpuSQi9va
         aGC9izDrUd6qCgJy/BIDdtY9sqz9a2KOKxQ8c3TSu6OrA8WdYO50mxGbdV/fvOX8dY
         iI/BhlwxQcuotJs/BjnicpJDD/why+P/HPlOODP6pDrYx8BIccB4sMequaXxIRHQms
         EQzJtZqv4EEvcPP1sLX9+NSmI/7e7egtktHRhqwZUcqc1WaCVCP46Yo+L/UQvD92O8
         meGoagQAZyj6w==
X-CNFS-Analysis: v=2.4 cv=OapdsjfY c=1 sm=1 tr=0 ts=6042235b cx=a_exe
 a=OOVL9cV9Sbj0kEPRW8Lb2w==:117 a=C-c6dMTymFoA:10 a=IkcTkHD0fZMA:10
 a=vesc6bHxzc4A:10 a=gu6fZOg2AAAA:8 a=L_Xriw9wJ9My5GVEneMA:9 a=QEXdDO2ut3YA:10
 a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10 a=2RSlZUUhi9gRBrsHwhhZ:22
 a=BPzZvq435JnGatEyYwdK:22
Date:   Fri, 5 Mar 2021 13:26:02 +0100 (CET)
From:   Dario Binacchi <dariobin@libero.it>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de
Message-ID: <1422328052.129511.1614947162932@mail1.libero.it>
In-Reply-To: <20210304154240.2747987-1-mkl@pengutronix.de>
References: <20210304154240.2747987-1-mkl@pengutronix.de>
Subject: Re: [PATCH v5 0/11] can: c_can: add support to 64 message objects
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.3-Rev27
X-Originating-IP: 185.33.57.41
X-Originating-Client: open-xchange-appsuite
x-libjamsun: w5wKeYPOYD3RagGlO7fXMUR4Z4v2pg2e
x-libjamv: l/LJIzwjTDk=
X-CMAE-Envelope: MS4xfNpxY16bFxifLEceM/7i72Q5bJphi5IOfx+OixUCwad27t+697MNcrsAnmqpHC4xyCEZfuS986x141KAynW6vIVK2XM0xcKKauagw/Pfsbwy5OVyawU6
 CaUCR2/+hWtyaEJQ/F+ZqNh6kE7gKUp6rf2v4K1OsKT8cf9CeMHHMw5Nibu2y9iUEViEG3Fh1izjK2Hx0l4EVDiLYs9m0pT6dF9dg7AelSqhpAF880mjm01P
 UcNJKSqvPyZ3rx2iA6kXKQqyOJj4RKtUl2dse2MO1/M=
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

> Il 04/03/2021 16:42 Marc Kleine-Budde <mkl@pengutronix.de> ha scritto:
> 
>  
> Hello,
> 
> this series picks up Dario Binacchi's patches and adds some cleanup
> patches in front.
> 
> The D_CAN controller supports up to 128 messages. Until now the driver
> only managed 32 messages although Sitara processors and DRA7 SOC can
> handle 64.
> 
> The series was tested on a beaglebone board.
> 
> Note:
> I have not changed the type of tx_field (belonging to the c_can_priv
> structure) to atomic64_t because I think the atomic_t type has size
> of at least 32 bits on x86 and arm, which is enough to handle 64
> messages.
> http://marc.info/?l=linux-can&m=139746476821294&w=2 reports the results
> of tests performed just on x86 and arm architectures.
> 
> Changes in v5:
> - Add cleanup patches
> - alloc_c_can_dev(): make use of struct_size()
> 
> Changes in v4:
> - Restore IF_RX interface.
> - Add a comment to clarify why IF_RX interface is used instead of IF_TX.
> - Use GENMASK() for setting msg_obj_rx_mask.
> - Use BIT() for setting single bits and GENMASK() for setting masks.
> 
> Changes in v3:
> - Use unsigned int instead of int as type of the msg_obj_* fields
>   in the c_can_priv structure.
> - Replace (u64)1 with 1UL in msg_obj_rx_mask setting.
> - Use unsigned int instead of int as type of the msg_obj_num field
>   in c_can_driver_data and c_can_pci_data structures.
> 
> Changes in v2:
> - Fix compiling error reported by kernel test robot.
> - Add Reported-by tag.
> - Pass larger size to alloc_candev() routine to avoid an additional
>   memory allocation/deallocation.
> - Add message objects number to PCI driver data.


The "can: c_can: add support to 64 message objects" patch is missing 
from the series.
Can I use version 4 or do you send it to me?

Thanks and regards
Dario
