Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC82133259E
	for <lists+linux-can@lfdr.de>; Tue,  9 Mar 2021 13:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhCIMlv (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Mar 2021 07:41:51 -0500
Received: from smtp-31-i2.italiaonline.it ([213.209.12.31]:40596 "EHLO
        libero.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229544AbhCIMlc (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 9 Mar 2021 07:41:32 -0500
Received: from oxapps-11-062.iol.local ([10.101.8.72])
        by smtp-31.iol.local with ESMTPA
        id Jbg3l9rW9VpAbJbg3l7SXg; Tue, 09 Mar 2021 13:41:31 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1615293691; bh=3o5+VsHZgtA11EBUsy294JHGkkQreeR6kHFtHPSgnu8=;
        h=From;
        b=GRxGkpFyvJdIhgt7gquWoIzpXws6pBgJlp4hBUI113AlBtIdDGKRH9nUhtO1vKgUp
         r9wHYzUPJKXmw9rwIt8dWS9uibUOToWe2Ey3sc8ozQY8uMVofepIntrYZs9cUThQ9O
         wpnIlnCPqP8/xAoZ+YpvXTgWrmFNS75WlhAnUX6Rn06/XlAyHkHCvo6qRGKUSQZdWv
         hgqL+fjt45unjDRpfgI3F5aKGvvta7wJMw0TK23JojLrwt9JVvDvGRn5txu4R+wO9O
         Pxu438/jo03bT/kI3NFUIeQtvYzrwuz1D+APb3ToLrHUTvUO3HwwMr7EuqhvSQHAVT
         DbTOiXkk59fzg==
X-CNFS-Analysis: v=2.4 cv=WMS64lgR c=1 sm=1 tr=0 ts=60476cfb cx=a_exe
 a=ArCppHiS2LX9rvfu7+HyXQ==:117 a=C-c6dMTymFoA:10 a=IkcTkHD0fZMA:10
 a=vesc6bHxzc4A:10 a=gu6fZOg2AAAA:8 a=qkFHNxRNrKAakAEVf68A:9 a=QEXdDO2ut3YA:10
 a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10 a=2RSlZUUhi9gRBrsHwhhZ:22
 a=BPzZvq435JnGatEyYwdK:22
Date:   Tue, 9 Mar 2021 13:41:31 +0100 (CET)
From:   Dario Binacchi <dariobin@libero.it>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de
Message-ID: <1739785095.246292.1615293691102@mail1.libero.it>
In-Reply-To: <20210305130211.2860914-1-mkl@pengutronix.de>
References: <20210305130211.2860914-1-mkl@pengutronix.de>
Subject: Re: [PATCH v6 0/12] can: c_can: add support to 64 message objects
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.3-Rev27
X-Originating-IP: 185.33.57.41
X-Originating-Client: open-xchange-appsuite
x-libjamsun: ZOUYbfK43OiFtnK2FIaUMltXpItcoY2/
x-libjamv: F9fNopjYPV0=
X-CMAE-Envelope: MS4xfL0hrdgSstfTzqtnFxQLVyQa+HpMDqpD8P8X6GsbMXZypG7vU9VvWIybgX54YHiirIlPWxe/RQUAWur/O+EL7L0KLd4mBf+gj6YrnQ2kU1bxV9HYegju
 qHyftOYZM47nuyU/hM5gAF3P4pFz8gqzPpx6JY/pwlT3pfMOzQLZsypDqNiVSZU1tUg4hnown4qanVJ0xy/VfseRbg1y40z1rTNClOeQxNDqJLzQzThdiOLq
 cNdB9zPHG4WoHGaLlGREIWdBEJol6jMZZq65FJhOPJc=
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

> Il 05/03/2021 14:01 Marc Kleine-Budde <mkl@pengutronix.de> ha scritto:
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
> Changes in v6:
> - make patches
>   [PATCH v5 0/11] can: c_can: add support to 64 message objects
>   [PATCH v5 0/11] can: c_can: add support to 64 message objects
>   separate again, they have been squashed accidentally 
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

I tested the patch series on a custom board having two CAN ports.
I connected the CAN1 port to the CAN2 port with a cable. Then I
opened two terminals. On one I issued a dump command and on the
other the transmit command used in the tests described in
https://marc.info/?l=linux-can&m=139746476821294&w=2.

Terminal-1:
$ ip link set can1 type can bitrate <bitrate>
$ ip link set up can1
$ candump -t can1 >/tmp/can-test-<bitrate>/out

Terminal-2
$ ip link set can0 type can bitrate <bitrate>
$ ip link set up can0
$ time cangen can0 -g0 -p1 -I5A5 -L0 -x -n 1000000

Then I applied the following commands to the file generated by the dump
command:
$ wc -l </tmp/can-test-<bitrate>                                 # ca
$ egrep -v '  can1  5A5   \[0\]' /tmp/can-test-<bitrate> | wc -l # cb

I repeated the tests for 1000000, 500000, 250000 and 125000 bitrates,
before and after applying the series.
Here are the results.

Before applying the series:

 bitrate       time         ca         cb
  125000    6m 45.22s    1000000        0
  250000    3m 25.94s    1000000        0
  500000    1m 45.62s    1000000        0
 1000000    1m  9.28s    1000000        0

After applying the series:

 bitrate       time         ca         cb
  125000    6m 42.71s    1000000        0
  250000    3m 23.28s    1000000        0
  500000    1m 44.04s    1000000        0
 1000000    1m  8.44s    1000000        0

Thanks and regards,
Dario
