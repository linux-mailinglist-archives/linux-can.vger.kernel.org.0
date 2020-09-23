Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3CF7275726
	for <lists+linux-can@lfdr.de>; Wed, 23 Sep 2020 13:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgIWL32 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 23 Sep 2020 07:29:28 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:45718 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgIWL32 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 23 Sep 2020 07:29:28 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08NBPUt4068531;
        Wed, 23 Sep 2020 11:29:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=1LyCS0TwPjWG693aSmZssqp+wWWmNSUUEOJiKI472j4=;
 b=MNxU++Q5zIw6qj6b3m4WJIs7dMzO7nxjMGLE8w+8CjcF9YH458vcx6oyt+5lK0sklZT5
 o3XMdvUoyLhMCUtEdH13ui/L/MOMMNhXQgLs1HZnIVX1L3nVRWofKvtNYy24vl1lpynp
 9fHkSiQJWBvyh1HsZEwy6SUsRusOf27EIE8Zkf2Fs798Gm6daR3QJMuHkm8rVt3nW34x
 QfsQxe87jja1+t/Lh+2MkJYrp7RuVx20lIumXTeUv0T2GevpHovZZjFwRQOxC3BA3lkD
 KA1S3fy7B5IFWV0T7+lGNq5Zi7d66Xjfk7Ykx42NQynTR9lF5Iet/h01vCKj+zS35cgq JQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 33qcptxt66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Sep 2020 11:29:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08NBQPhh008670;
        Wed, 23 Sep 2020 11:29:23 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 33nurugrwa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Sep 2020 11:29:23 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08NBTNEo019615;
        Wed, 23 Sep 2020 11:29:23 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 23 Sep 2020 04:29:22 -0700
Date:   Wed, 23 Sep 2020 14:29:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     mkl@pengutronix.de
Cc:     linux-can@vger.kernel.org
Subject: [bug report] can: mcp25xxfd: add driver for Microchip MCP25xxFD SPI
 CAN
Message-ID: <20200923112917.GB1473821@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9752 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=818 bulkscore=0 mlxscore=0 suspectscore=3
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009230092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9752 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 mlxlogscore=833
 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009230092
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Marc Kleine-Budde,

The patch 55e5b97f003e: "can: mcp25xxfd: add driver for Microchip
MCP25xxFD SPI CAN" from Sep 18, 2020, leads to the following static
checker warning:

	drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c:2155 mcp25xxfd_irq()
	error: uninitialized symbol 'set_normal_mode'.

drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c
  2074          do {
  2075                  u32 intf_pending, intf_pending_clearable;
  2076                  bool set_normal_mode;
                        ^^^^^^^^^^^^^^^^^^^^
  2077  
  2078                  err = regmap_bulk_read(priv->map_reg, MCP25XXFD_REG_INT,
  2079                                         &priv->regs_status,
  2080                                         sizeof(priv->regs_status) /
  2081                                         sizeof(u32));
  2082                  if (err)
  2083                          goto out_fail;
  2084  
  2085                  intf_pending = FIELD_GET(MCP25XXFD_REG_INT_IF_MASK,
  2086                                           priv->regs_status.intf) &
  2087                          FIELD_GET(MCP25XXFD_REG_INT_IE_MASK,
  2088                                    priv->regs_status.intf);
  2089  
  2090                  if (!(intf_pending))
  2091                          return handled;
  2092  
  2093                  /* Some interrupts must be ACKed in the
  2094                   * MCP25XXFD_REG_INT register.
  2095                   * - First ACK then handle, to avoid lost-IRQ race
  2096                   *   condition on fast re-occurring interrupts.
  2097                   * - Write "0" to clear active IRQs, "1" to all other,
  2098                   *   to avoid r/m/w race condition on the
  2099                   *   MCP25XXFD_REG_INT register.
  2100                   */
  2101                  intf_pending_clearable = intf_pending &
  2102                          MCP25XXFD_REG_INT_IF_CLEARABLE_MASK;
  2103                  if (intf_pending_clearable) {
  2104                          err = regmap_update_bits(priv->map_reg,
  2105                                                   MCP25XXFD_REG_INT,
  2106                                                   MCP25XXFD_REG_INT_IF_MASK,
  2107                                                   ~intf_pending_clearable);
  2108                          if (err)
  2109                                  goto out_fail;
  2110                  }
  2111  
  2112                  if (intf_pending & MCP25XXFD_REG_INT_MODIF) {
                                           ^^^^^^^^^^^^^^^^^^^^^^^
This is BIT(3)

  2113                          err = mcp25xxfd_handle(priv, modif, &set_normal_mode);
                                                                    ^^^^^^^^^^^^^^^^
  2114                          if (err)
  2115                                  goto out_fail;
  2116                  }
  2117  
  2118                  if (intf_pending & MCP25XXFD_REG_INT_RXIF) {
  2119                          err = mcp25xxfd_handle(priv, rxif);
  2120                          if (err)
  2121                                  goto out_fail;
  2122                  }
  2123  
  2124                  if (intf_pending & MCP25XXFD_REG_INT_TEFIF) {
  2125                          err = mcp25xxfd_handle(priv, tefif);
  2126                          if (err)
  2127                                  goto out_fail;
  2128                  }
  2129  
  2130                  if (intf_pending & MCP25XXFD_REG_INT_RXOVIF) {
  2131                          err = mcp25xxfd_handle(priv, rxovif);
  2132                          if (err)
  2133                                  goto out_fail;
  2134                  }
  2135  
  2136                  if (intf_pending & MCP25XXFD_REG_INT_TXATIF) {
  2137                          err = mcp25xxfd_handle(priv, txatif);
  2138                          if (err)
  2139                                  goto out_fail;
  2140                  }
  2141  
  2142                  if (intf_pending & MCP25XXFD_REG_INT_IVMIF) {
  2143                          err = mcp25xxfd_handle(priv, ivmif);
  2144                          if (err)
  2145                                  goto out_fail;
  2146                  }
  2147  
  2148                  if (intf_pending & MCP25XXFD_REG_INT_SERRIF) {
  2149                          err = mcp25xxfd_handle(priv, serrif);
  2150                          if (err)
  2151                                  goto out_fail;
  2152                  }
  2153  
  2154                  if (intf_pending & MCP25XXFD_REG_INT_ECCIF) {
                                           ^^^^^^^^^^^^^^^^^^^^^^^
This is BIT(8)

  2155                          err = mcp25xxfd_handle(priv, eccif, set_normal_mode);
                                                                    ^^^^^^^^^^^^^^^^
This might not be initialized if BIT(8) is set but BIT(3) is not.

  2156                          if (err)
  2157                                  goto out_fail;

regards,
dan carpenter
