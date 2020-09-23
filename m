Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732102754DD
	for <lists+linux-can@lfdr.de>; Wed, 23 Sep 2020 11:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgIWJzC (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 23 Sep 2020 05:55:02 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46890 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWJzB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 23 Sep 2020 05:55:01 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08N9nviW155253;
        Wed, 23 Sep 2020 09:54:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=TtfOk5yEqYhvyhIUPR8SGPo5Nf9CR0mBltqbFAIbdXc=;
 b=xEVJRejqgjnwi7cWDb6oBuG6XP4kZpkdhQjnWKS0Zd3aMDumO2tCMV4SsyDDgs19/aqE
 pIYLxfNzxCJIj+nfyqhD9pRg3hlDP1qYflRVYHu32JRr1YAH+jAbhVsNfUkIJ6YU3oau
 fk07BlAdud5Fz5cNjenownPi8xQC1bRrV0vSzOO8KEhVeRUR4O2/1+yvKui2eWIYR7bH
 6on3qE9B1MRWH6EiCkrghe/PrJghUAYPIdz0YTDhxs63voFywffj4xXZghBXjn626FgM
 VdmrFs/WoHzh5FhLCQWXOlXob1CR00W+pWVW55m3GWYBHyFI+xqH4gFLthupPtNlV/YP 2Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 33q5rgfvjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Sep 2020 09:54:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08N9oNPf175336;
        Wed, 23 Sep 2020 09:54:54 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 33nujpd7t8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Sep 2020 09:54:54 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08N9srxf010429;
        Wed, 23 Sep 2020 09:54:53 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 23 Sep 2020 02:54:52 -0700
Date:   Wed, 23 Sep 2020 12:54:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     mkl@pengutronix.de
Cc:     linux-can@vger.kernel.org
Subject: [bug report] can: mcp25xxfd: add driver for Microchip MCP25xxFD SPI
 CAN
Message-ID: <20200923095447.GA1464378@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9752 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 adultscore=0 spamscore=0 suspectscore=3
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009230076
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9752 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 impostorscore=0
 clxscore=1011 suspectscore=3 phishscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009230076
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Marc Kleine-Budde,

The patch 55e5b97f003e: "can: mcp25xxfd: add driver for Microchip
MCP25xxFD SPI CAN" from Sep 18, 2020, leads to the following static
checker Smatch warning:

drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c:2271 mcp25xxfd_tx_obj_from_skb() warn: user controlled 'len' cast to postive rl = '(-249)-(-1),1-67'
drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c:2272 mcp25xxfd_tx_obj_from_skb() error: 'memcpy()' 'hw_tx_obj->data' too small (64 vs 255)
drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c:2272 mcp25xxfd_tx_obj_from_skb() error: 'memcpy()' 'cfd->data' too small (64 vs 255)
drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c:2272 mcp25xxfd_tx_obj_from_skb() error: 'cfd->len' from user is not capped properly

(Only one of these checks is published and it's disabled unless you
run with the --spammy flag).

drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c
  2208  static void
  2209  mcp25xxfd_tx_obj_from_skb(const struct mcp25xxfd_priv *priv,
  2210                            struct mcp25xxfd_tx_obj *tx_obj,
  2211                            const struct sk_buff *skb,
  2212                            unsigned int seq)
  2213  {
  2214          const struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
                                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Smatch distrusts all skb->data information.

  2215          struct mcp25xxfd_hw_tx_obj_raw *hw_tx_obj;
  2216          union mcp25xxfd_tx_obj_load_buf *load_buf;
  2217          u8 dlc;
  2218          u32 id, flags;
  2219          int offset, len;
  2220  
  2221          if (cfd->can_id & CAN_EFF_FLAG) {
  2222                  u32 sid, eid;
  2223  
  2224                  sid = FIELD_GET(MCP25XXFD_REG_FRAME_EFF_SID_MASK, cfd->can_id);
  2225                  eid = FIELD_GET(MCP25XXFD_REG_FRAME_EFF_EID_MASK, cfd->can_id);
  2226  
  2227                  id = FIELD_PREP(MCP25XXFD_OBJ_ID_EID_MASK, eid) |
  2228                          FIELD_PREP(MCP25XXFD_OBJ_ID_SID_MASK, sid);
  2229  
  2230                  flags = MCP25XXFD_OBJ_FLAGS_IDE;
  2231          } else {
  2232                  id = FIELD_PREP(MCP25XXFD_OBJ_ID_SID_MASK, cfd->can_id);
  2233                  flags = 0;
  2234          }
  2235  
  2236          /* Use the MCP2518FD mask even on the MCP2517FD. It doesn't
  2237           * harm, only the lower 7 bits will be transferred into the
  2238           * TEF object.
  2239           */
  2240          dlc = can_len2dlc(cfd->len);
  2241          flags |= FIELD_PREP(MCP25XXFD_OBJ_FLAGS_SEQ_MCP2518FD_MASK, seq) |
  2242                  FIELD_PREP(MCP25XXFD_OBJ_FLAGS_DLC, dlc);
  2243  
  2244          if (cfd->can_id & CAN_RTR_FLAG)
  2245                  flags |= MCP25XXFD_OBJ_FLAGS_RTR;
  2246  
  2247          /* CANFD */
  2248          if (can_is_canfd_skb(skb)) {
  2249                  if (cfd->flags & CANFD_ESI)
  2250                          flags |= MCP25XXFD_OBJ_FLAGS_ESI;
  2251  
  2252                  flags |= MCP25XXFD_OBJ_FLAGS_FDF;
  2253  
  2254                  if (cfd->flags & CANFD_BRS)
  2255                          flags |= MCP25XXFD_OBJ_FLAGS_BRS;
  2256          }
  2257  
  2258          load_buf = &tx_obj->buf;
  2259          if (priv->devtype_data.quirks & MCP25XXFD_QUIRK_CRC_TX)
  2260                  hw_tx_obj = &load_buf->crc.hw_tx_obj;
  2261          else
  2262                  hw_tx_obj = &load_buf->nocrc.hw_tx_obj;
  2263  
  2264          put_unaligned_le32(id, &hw_tx_obj->id);
  2265          put_unaligned_le32(flags, &hw_tx_obj->flags);
  2266  
  2267          /* Clear data at end of CAN frame */
  2268          offset = round_down(cfd->len, sizeof(u32));
  2269          len = round_up(can_dlc2len(dlc), sizeof(u32)) - offset;

Smatch thinks that "cfd->len" can be more than 64 which leads to setting
"len" negative.

  2270          if (MCP25XXFD_SANITIZE_CAN && len)
  2271                  memset(hw_tx_obj->data + offset, 0x0, len);
                                                              ^^^
Which would corrupt memory.

  2272          memcpy(hw_tx_obj->data, cfd->data, cfd->len);
                                                   ^^^^^^^^
Smatch thinks this can be more than 64.

  2273  
  2274          /* Number of bytes to be written into the RAM of the controller */
  2275          len = sizeof(hw_tx_obj->id) + sizeof(hw_tx_obj->flags);

regards,
dan carpenter
